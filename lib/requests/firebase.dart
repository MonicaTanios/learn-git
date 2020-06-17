import 'package:firebase_database/firebase_database.dart';
import 'package:learngit/models/level.dart';
import 'package:learngit/models/user.dart';

class FirebaseRequest {
  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  static List<Level> levels = [];
  static User user;

  static List<Level> getLevels() {
    databaseReference.child('levels').once().then((DataSnapshot dataSnapShot) {
      for (var level in dataSnapShot.value) {
        levels.add(new Level.fromJson(level));
      }
    });
    return levels;
  }

  static void setUser(User user)
  {
    databaseReference.child('users').child(user.login).set(
      user.toMap()
    );
  }

  static User getUser(String username)
  {
    databaseReference.child('users').child(username).once().then((DataSnapshot dataSnapShot) {
      user = User.fromJson(dataSnapShot.value);
    });
    return user;
  }
}
