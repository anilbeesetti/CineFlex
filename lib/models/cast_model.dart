import 'package:flutter/foundation.dart';

class Cast {
  final int id;
  final String name;
  final String profilePath;
  final String characterName;
  final String creditId;
  final int gender;

  Cast({
    @required this.gender,
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
  final int gender;

  Crew({
    @required this.gender,
    @required this.id,
    @required this.name,
    @required this.profilePath,
    @required this.department,
    @required this.creditId,
    @required this.job,
  });
}

class CastInfo {
  final int id;
  final String birthDay;
  final String biography;
  final String deathDay;
  final String knownForDepartment;
  final String placeOfBirth;
  final List alsoKnownAs;

  CastInfo({
    this.id,
    this.birthDay,
    this.biography,
    this.deathDay,
    this.knownForDepartment,
    this.placeOfBirth,
    this.alsoKnownAs,
  });
}
