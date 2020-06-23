import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:learngit/models/command.dart';
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/palette.dart';
import 'package:learngit/repositories/user_repository.dart';
import 'package:learngit/screens/level_screen.dart';
import 'package:provider/provider.dart';

class CommandsScreen extends StatefulWidget {
  @override
  _CommandsScreenState createState() => _CommandsScreenState();
}

class _CommandsScreenState extends State<CommandsScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context).getUser();
    final Level level = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Commands'),
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
                    builder: (context) => LevelScreen(),
                    settings: RouteSettings(
                      arguments: level,
                    ),
                  ));
            },
          ),
          backgroundColor: Palette.secondary,
        ),
        backgroundColor: Palette.primary,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Palette.secondary,
          label: Text(
            "Test",
            style: TextStyle(fontSize: 20),
          ),
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            (level.title == '1')
                ? user.levelOneRate = 0.5
                : (level.title == '2')
                    ? user.levelTwoRate = 0.5
                    : (level.title == '3')
                        ? user.levelThreeRate = 0.5
                        : (level.title == '4')
                            ? user.levelFourRate = 0.5
                            : user.levelFiveRate = 0.5;
            //TODO: Implement Test Screen
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: level.commands?.length ?? 0,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.code,
                          color: Colors.blue[800],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 24,
                        ),
                        Text(
                          'git ${level.commands[index].name}',
                          style: new TextStyle(
                            fontSize: 24.0,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Usage:',
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              level.commands[index].usage,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 32,
                            ),
                            Text(
                              'Example:',
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              level.commands[index].example,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    trailing: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue[800],
                      ),
                      onPressed: () {},
                    ),
                  );
                }),
          ),
        ));
  }
}
