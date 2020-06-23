import '../palette.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/repositories/user_repository.dart';
import 'package:learngit/requests/firebase.dart';
import 'package:learngit/screens/level_screen.dart';
import 'package:learngit/screens/login_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  static String ratingData;
  static List<Level> levels;

  @override
  void initState() {
    setState(() {});
    asyncInitState();
    setState(() {});
    super.initState();
    setState(() {});
  }

  void asyncInitState() async {
    setState(() {});
    Future.delayed(const Duration(milliseconds: 3000), () async {
      levels = [];
      user = null;
      user = Provider.of<UserRepository>(context).getUser();
      user.calculateRate();
      levels = FirebaseRequest.getLevels();
      levels = levels.sublist(0, 5);
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? Container(
            color: Palette.primary,
            child: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.secondary)),
            ),
          )
        : Scaffold(
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
                                  builder: (context) => LoginScreen()));
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
                                  backgroundImage:
                                      NetworkImage(user.avatar_url),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              Text(
                                'Welcome ${user.login} !',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              levels != null
                                  ? Container(
                                      alignment: Alignment.topCenter,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        itemCount: levels?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                  leading: Icon(
                                                    Icons.stars,
                                                    color: Colors.yellow,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        14,
                                                  ),
                                                  title: Text(
                                                    'Level #${levels[index].title}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20),
                                                  ),
                                                  subtitle: Text(
                                                      levels[index].description,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  trailing:
                                                      CircularPercentIndicator(
                                                    radius: 45.0,
                                                    lineWidth: 4.0,
                                                    percent: (levels[index]
                                                                .title ==
                                                            '1')
                                                        ? user.levelOneRate
                                                        : (levels[index]
                                                                    .title ==
                                                                '2')
                                                            ? user.levelTwoRate
                                                            : (levels[index]
                                                                        .title ==
                                                                    '3')
                                                                ? user
                                                                    .levelThreeRate
                                                                : (levels[index]
                                                                            .title ==
                                                                        '4')
                                                                    ? user
                                                                        .levelFourRate
                                                                    : user
                                                                        .levelFiveRate,
                                                    center: new Text(
                                                        (levels[index].title ==
                                                                '1')
                                                            ? "${user.levelOneRate * 100}%"
                                                            : (levels[index]
                                                                        .title ==
                                                                    '2')
                                                                ? "${user.levelTwoRate * 100}%"
                                                                : (levels[index]
                                                                            .title ==
                                                                        '3')
                                                                    ? "${user.levelThreeRate * 100}%"
                                                                    : (levels[index].title ==
                                                                            '4')
                                                                        ? "${user.levelFourRate * 100}%"
                                                                        : "${user.levelFiveRate * 100}%",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                    progressColor: Colors.green,
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LevelScreen(),
                                                          settings:
                                                              RouteSettings(
                                                            arguments:
                                                                levels[index],
                                                          ),
                                                        ));
                                                  },
                                                  enabled: (levels[index].title ==
                                                          '1')
                                                      ? true
                                                      : (levels[index].title ==
                                                                  '2' &&
                                                              user.rate >= 1)
                                                          ? true
                                                          : (levels[index].title ==
                                                                      '3' &&
                                                                  user.rate >=
                                                                      2)
                                                              ? true
                                                              : (levels[index].title ==
                                                                          '4' &&
                                                                      user.rate >=
                                                                          3)
                                                                  ? true
                                                                  : (levels[index].title ==
                                                                              '5' &&
                                                                          user.rate >=
                                                                              4)
                                                                      ? true
                                                                      : false),
                                              Divider(
                                                color: Colors.white,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : Text('')
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
}
