import 'package:flutter/foundation.dart';

class Cast {
  final int id;
  final String name;
  final String profilePath;
  final String characterName;
  final String creditId;

  Cast({
    @required this.id,
    @required this.name,
    @required this.profilePath,
    @required this.characterName,
    @required this.creditId,
  });
}

class Crew {
  final int id;
  final String name;
  final String profilePath;
  final String department;
  final String creditId;
  final String job;

  Crew({
    @required this.id,
    @required this.name,
    @required this.profilePath,
    @required this.department,
    @required this.creditId,
    @required this.job,
  });
}
