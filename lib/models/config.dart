import 'package:flutter/foundation.dart';

class Config {
  final String? id;
  final String urlservice;
  final String username;
  final String pass;
  final String acacount;
  final String acpass;
  final String pattern;
  final String serial;

  Config({
    this.id,
    required this.urlservice,
    required this.username,
    required this.pass,
    required this.acacount,
    required this.acpass,
    required this.pattern,
    required this.serial,
  });

  Config copyWith({
    String? id,
    String? urlservice,
    String? username,
    String? pass,
    String? acacount,
    String? acpass,
    String? pattern,
    String? serial,
  }) {
    return Config(
      id: id ?? this.id,
      urlservice: urlservice ?? this.urlservice,
      username: username ?? this.username,
      pass: pass ?? this.pass,
      acacount: acacount ?? this.acacount,
      acpass: acpass ?? this.acpass,
      pattern: pattern ?? this.pattern,
      serial: serial ?? this.serial);
  }
}
