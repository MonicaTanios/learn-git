class Command {
  String name;
  String usage;
  String example;

  Command({
    this.name,
    this.usage,
    this.example
  });

  factory Command.fromJson(Map json) {
    return Command(
      name: json['name'],
      usage: json['usage'],
      example: json['example'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'usage': usage,
      'example': example,
    };
  }

  @override
  String toString() {
    return '''Command {
      name: $name,
      usage: $usage,
      example: $example
    }''';
  }

}