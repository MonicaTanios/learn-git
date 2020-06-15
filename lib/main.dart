import 'package:flutter/material.dart';
import 'package:learngit/providers/user_provider.dart';
import 'package:learngit/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider<UserProvider>(
    builder: (context) => UserProvider(),
    child: MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    ),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Git',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Learn Git Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SplashScreen()
        );
  }
}
