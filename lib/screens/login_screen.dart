import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learngit/palette.dart';
import 'package:learngit/providers/user_provider.dart';
import 'package:learngit/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _usernameController.text = '';
  }

  var _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).user = null;
    setState(() {
      Provider.of<UserProvider>(context).setLoading(false);
    });
    return ChangeNotifierProvider(
      builder: (context) => UserProvider(),
      child: Consumer<UserProvider>(
        builder: (context, user, child) => Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Palette.primary,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 16,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/github.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                    Text(
                      "Step #1: Have Github account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Palette.secondary),
                      child: TextField(
                        controller: _usernameController,
                        onChanged: (value) {
                          Provider.of<UserProvider>(context).setMessage(null);
                        },
                        enabled:
                            !Provider.of<UserProvider>(context).isLoading(),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            errorText:
                                Provider.of<UserProvider>(context).getMessage(),
                            border: InputBorder.none,
                            hintText: "Github username",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Don\'t\ have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Palette.secondary,
                          title: Text("Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          content: Text("Sign Up then enter your username",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          actions: [
                            FlatButton(
                              child: Text("Sign Up"),
                              onPressed: () {
                                if (canLaunch('https://github.com/join') !=
                                    null) {
                                  launch('https://github.com/join');
                                }
                              },
                            ),
                            FlatButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('alert');
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.9,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                        ),
                        Provider.of<UserProvider>(context).isLoading()
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Palette.secondary))
                            : SizedBox.fromSize(
                                size: Size(
                                    MediaQuery.of(context).size.height / 7,
                                    MediaQuery.of(context).size.height / 7),
                                child: ClipOval(
                                  child: Material(
                                    color: Palette.secondary,
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        if (_usernameController.text == '') {
                                          setState(() {
                                            Provider.of<UserProvider>(context)
                                                    .errorMessage =
                                                'Please Enter your GitHub Username';
                                          });
                                        } else
                                          setState(() {
                                            Provider.of<UserProvider>(context)
                                                .setLoading(true);
                                            onNextStepButtonPressed();
                                          });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  18),
                                          Text(
                                            "Next Step",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    40,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onNextStepButtonPressed() {
    Provider.of<UserProvider>(context)
        .fetchUser(_usernameController.text)
        .then((value) {
      if (value) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    });
  }
}
