import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  AlertDialog alert = AlertDialog(
    title: Text("Sign Up"),
    content: Text("Sign Up then enter your username"),
    actions: [
      FlatButton(
        child: Text("OK"),
        onPressed: () {
          if (canLaunch('https://github.com/join') != null) {
            launch('https://github.com/join');
          }
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.1)),
                  child: TextField(
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Github Username",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Don\'t\ have an account?',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => alert,
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
                    SizedBox.fromSize(
                      size: Size(
                          MediaQuery.of(context).size.height / 7,
                          MediaQuery.of(context).size.height /
                              7),
                      child: ClipOval(
                        child: Material(
                          color: Colors.white.withOpacity(.1),
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.height / 18
                                ),
                                Text(
                                  "Next Step",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginScreenButtonPress() async {
    print('Login Pressed !');
  }
}
