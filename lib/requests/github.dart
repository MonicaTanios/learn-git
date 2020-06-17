import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class Github {
  final String userName;
  final String url = 'https://api.github.com/';
  static String client_id;
  static String client_secret;

  final String query = "?client_id=${client_id}&client_secret=${client_secret}";

  Github(this.userName);

  Future<http.Response> fetchUser() async {
    String data = await rootBundle.loadString('assets/data/oauthGithub.txt');
    List<String> secretData = data.split('\n');
    client_id = secretData[0].trim();
    client_secret = secretData[1].trim();
    return http.get(url + 'users/' + userName + query);
  }
}
