import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String pronoun;
  final String bio;
  final String avatar;
  final String location;
  final String link;
  final int age;
  final int ecoPoints;
  final List<dynamic> ventures;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String role;

  int get totalVentures => ventures.length;
  int get totalFollowers => followers.length;
  int get totalFollowing => following.length;
  String get displayLink => link.split("https://").last;

  const User({
    required this.name,
    required this.email,
    required this.pronoun,
    required this.bio,
    required this.avatar,
    required this.location,
    required this.link,
    required this.age,
    required this.ecoPoints,
    required this.ventures,
    required this.followers,
    required this.following,
    required this.role,
  });
  @override
  List<Object?> get props => [name, email];
}
