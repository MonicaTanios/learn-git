class Level {
  String title;
  String description;
  String numOfCommands;
  //TODO: Add Commands
  //TODO: Add Questions

  Level({
    this.title,
    this.description,
    this.numOfCommands,
  });

  factory Level.fromJson(Map json) {
    return Level(
      title: json['title'],
      description: json['description'],
      numOfCommands: json['numOfCommands'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'numOfCommands': numOfCommands,
    };
  }

  @override
  String toString() {
    return '''Level {
      title: $title,
      description: $description,
      numOfCommands: $numOfCommands,
    }''';
  }

}