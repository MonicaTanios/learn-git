import 'package:learngit/models/command.dart';

class Level {
  String title;
  String description;
  String numOfCommands;
  List<Command> commands;
  //TODO: Add Questions

  Level({
    this.title,
    this.description,
    this.numOfCommands,
    this.commands
  });

  factory Level.fromJson(Map json) {
    return Level(
      title: json['title'],
      description: json['description'],
      numOfCommands: json['numOfCommands'],
      commands: (json['commands'] as List).map((i) => Command.fromJson(i)).toList()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'numOfCommands': numOfCommands,
      'commands' : commands
    };
  }

  @override
  String toString() {
    return '''Level {
      title: $title,
      description: $description,
      numOfCommands: $numOfCommands,
      commands: $commands
    }''';
  }

}