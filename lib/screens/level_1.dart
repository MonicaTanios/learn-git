import 'package:flutter/material.dart';
import 'package:learngit/models/user.dart';
import 'package:learngit/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LevelOneScreen extends StatefulWidget {
  @override
  _LevelOneScreenState createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUser();
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
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
              backgroundColor: Colors.black,
              expandedHeight: MediaQuery.of(context).size.height / 3,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
