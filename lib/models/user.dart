class User {
  String login;
  String avatar_url;
  String html_url;

  User({
    this.login,
    this.avatar_url,
    this.html_url
  });

  factory User.fromJson(Map json) {
    return User(
      login: json['login'],
      avatar_url: json['avatar_url'],
      html_url: json['html_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'avatar_url': avatar_url,
      'html_url': html_url,
    };
  }

  @override
  String toString() {
    return '''User {
      login: $login,
      avatar_url: $avatar_url,
      html_url: $html_url
    }''';
  }
}