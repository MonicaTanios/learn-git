import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/material.dart';
import 'package:learngit/providers/user_provider.dart';
import 'package:learngit/screens/level_1.dart';
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
  }

  var _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserProvider(),
      child: Consumer<UserProvider>(
        builder: (context, user, child) => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
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
                          color: Colors.white.withOpacity(.1)),
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
                          title: Text("Sign Up"),
                          content: Text("Sign Up then enter your username"),
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
                      height: MediaQuery.of(context).size.height / 4.5,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                        ),
                        !Provider.of<UserProvider>(context).isLoading()
                            ? SizedBox.fromSize(
                                size: Size(
                                    MediaQuery.of(context).size.height / 7,
                                    MediaQuery.of(context).size.height / 7),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white.withOpacity(.1),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        _onNextStepButtonPressed();
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
                            : CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red)),
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

  void _onNextStepButtonPressed() {
    Provider.of<UserProvider>(context)
        .fetchUser(_usernameController.text)
        .then((value) {
      if (value) {
        print(_usernameController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LevelOneScreen()));
      }
    });
  }
}
