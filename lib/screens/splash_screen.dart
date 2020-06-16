import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:learngit/palette.dart';
import 'package:learngit/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.primary,
      child: Padding(
            padding: const EdgeInsets.all(32),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Column(children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Text(
                  'Welcome to Learn Git !',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,),
                ),
                Expanded(
                  child: FlareActor(
                    'assets/coding.flr',
                    animation: 'coding',
                  ),
                ),
                Text(
                  'Tap to continue ...',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
              ]),
            ),
          ),
    );
  }
}