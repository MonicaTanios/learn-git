class User {
  String login;
  String avatar_url;
  String html_url;
  double rate;
  double levelOneRate;
  double levelTwoRate;
  double levelThreeRate;
  double levelFourRate;
  double levelFiveRate;

  User({
    this.login,
    this.avatar_url,
    this.html_url,
    this.rate,
    this.levelOneRate,
    this.levelTwoRate,
    this.levelThreeRate,
    this.levelFourRate,
    this.levelFiveRate,
  });

  void firstTime() {
    this.levelOneRate = 0;
    this.levelTwoRate = 0;
    this.levelThreeRate = 0;
    this.levelFourRate = 0;
    this.levelFiveRate = 0;
    this.rate = 0;
  }

  void calculateRate() {
    this.rate = this.levelOneRate +
        this.levelTwoRate +
        this.levelThreeRate +
        this.levelFourRate +
        this.levelFiveRate;
  }

  void setRate(double rate) {
    this.rate = rate;
  }

  factory User.fromJson(Map json) {
    return User(
        login: json['login'],
        avatar_url: json['avatar_url'],
        html_url: json['html_url'],
        levelOneRate: json['levelOneRate'],
        levelTwoRate: json['levelTwoRate'],
        levelThreeRate: json['levelThreeRate'],
        levelFourRate: json['levelFourRate'],
        levelFiveRate: json['levelFiveRate']);
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'avatar_url': avatar_url,
      'html_url': html_url,
      'levelOneRate': levelOneRate,
      'levelTwoRate': levelTwoRate,
      'levelThreeRate': levelThreeRate,
      'levelFourRate': levelFourRate,
      'levelFiveRate': levelFiveRate
    };
  }

  @override
  String toString() {
    return '''User {
      login: $login,
      avatar_url: $avatar_url,
      html_url: $html_url,
      levelOneRate'  : $levelOneRate,
      levelTwoRate'  : $levelTwoRate,
      levelThreeRate': $levelThreeRate,
      levelFourRate' : $levelFourRate,
      levelFiveRate' : $levelFiveRate
    }''';
  }
}
