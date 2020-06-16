import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/providers/user_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../palette.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  static String ratingData;
  static String levelsData;
  static List<Level> levels;

  @override
  void initState() {
    asyncInitState();
    super.initState();
  }

  void asyncInitState() async {
    ratingData = await readFile('assets/data/userRate.txt');
    levelsData = await readFile('assets/data/levels.json');
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUser();
      user.setRate(double.parse(ratingData));
      levels = jsonDecode(levelsData)
          .map<Level>(
              (dynamic challengeUpload) => Level.fromJson(challengeUpload))
          .toList();
    });
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
                  },
                ),
                backgroundColor: Palette.primary,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.height / 6,
                          height: MediaQuery.of(context).size.height / 6,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(user.avatar_url),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Text(
                          'Welcome ${user.login} !',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SmoothStarRating(
                          rating: user.rate,
                          isReadOnly: true,
                          size: 40,
                          filledIconData: Icons.star,
                          starCount: 5,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                        ),
                        Text(
                          '${(user.rate / 5) * 100} % done',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height / 1.8,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: levels.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.stars,
                                      color: Colors.yellow,
                                      size:
                                          MediaQuery.of(context).size.width / 14,
                                    ),
                                    title: Text(
                                      'Level #${levels[index].title}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.of(context).size.width /
                                                  20),
                                    ),
                                    subtitle: Text(levels[index].description,
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    trailing: CircularPercentIndicator(
                                      radius: 45.0,
                                      lineWidth: 4.0,
                                      percent: 0.90,
                                      center: new Text("90%",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      progressColor: Colors.green,
                                    ),
                                    onTap: (){
                                      //TODO: Go to level
                                    },
                                    enabled: true,
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> readFile(String path) async {
    return await rootBundle.loadString(path);
  }
}
