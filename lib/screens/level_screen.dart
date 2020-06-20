import 'package:flutter/material.dart';
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/palette.dart';
import 'package:learngit/repositories/user_repository.dart';
import 'package:learngit/screens/profile_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class LevelScreen extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context).getUser();
    final Level level = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Palette.primary,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Palette.primary,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  brightness: Brightness.light,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                  ),
                  backgroundColor: Palette.primary,
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 10,
                            ),
                            Text('Level #${level.title}',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
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
                                    color: Colors.white,
                                  )),
                              progressColor: Colors.green,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                            ),
                            Text('Description: ${level.description}',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                )),
                            Container(
                              alignment: Alignment.topCenter,
                              height: MediaQuery.of(context).size.height / 1.8,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: level.commands?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Column(children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.code,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          'Git ${level.commands[index].name}',
                                          style: TextStyle(
                                            fontFamily: 'Consolas',
                                              color: Colors.green,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20),
                                        ),
                                        subtitle:
                                            Text(level.commands[index].usage,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                      )
                                    ]);
                                  }),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CommandItem extends StatelessWidget {
  Widget _buildTiles(Level level) {
    if (level.commands.isEmpty) {
      return ListTile(
        title: Text(level.title, style: TextStyle(color: Colors.white)),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Level>(level),
      title: Text(level.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
      // children: level.commands.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return _buildTiles(level);
  }
}
