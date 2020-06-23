import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/palette.dart';
import 'package:learngit/repositories/user_repository.dart';
import 'package:learngit/screens/commands_screen.dart';
import 'package:learngit/screens/profile_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context).getUser();
    final Level level = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Level #${level.title}'),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            },
          ),
          backgroundColor: Palette.secondary,
        ),
        backgroundColor: Palette.primary,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
          ),
          backgroundColor: Palette.secondary,
          label: Text(
            "Commands",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommandsScreen(),
                  settings: RouteSettings(
                    arguments: level,
                  ),
                ));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Palette.primary,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 4.0,
                    percent: (level.title == '1')
                        ? user.levelOneRate
                        : (level.title == '2')
                            ? user.levelTwoRate
                            : (level.title == '3')
                                ? user.levelOneRate
                                : (level.title == '4')
                                    ? user.levelFourRate
                                    : user.levelFiveRate,
                    center: new Text(
                        (level.title == '1')
                            ? "${user.levelOneRate * 100}%"
                            : (level.title == '2')
                                ? "${user.levelTwoRate * 100}%"
                                : (level.title == '3')
                                    ? "${user.levelThreeRate * 100}%"
                                    : (level.title == '4')
                                        ? "${user.levelFourRate * 100}%"
                                        : "${user.levelFiveRate * 100}%",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    progressColor: Colors.green,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 16),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Description:',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(level.description,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                ]),
          ),
        ));
  }
}
