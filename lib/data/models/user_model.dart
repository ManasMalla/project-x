import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:socialpreneur/data/models/venture_model.dart';
import 'package:socialpreneur/domain/entity/user.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String pronoun;
  final String bio;
  final int avatar;
  final String location;
  final String link;
  final int age;
  final int ecoPoints;
  final List<dynamic> ventures;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String role;

  const UserModel({
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

  factory UserModel.fromDocumentSnapshot(
          DocumentSnapshot snapshot,
          List<DocumentSnapshot> mappedVentures,
          List<DocumentSnapshot> mappedFollowers,
          List<DocumentSnapshot> mappedFollowing) =>
      UserModel(
        name: snapshot.get("name"),
        email: snapshot.get("email"),
        pronoun: snapshot.get("pronoun"),
        bio: snapshot.get("bio"),
        avatar: snapshot.get("profile-pic"),
        location: snapshot.get("location"),
        link: snapshot.get("link"),
        age: snapshot.get("age"),
        ecoPoints: snapshot.get("eco-points"),
        ventures: mappedVentures
            .map((e) => VentureModel.fromDocumentSnapshot(e).toEntity())
            .toList(),
        followers: mappedFollowers.map((e) => e.data()).toList(),
        following: mappedFollowing.map((e) => e.data()).toList(),
        role: snapshot.get("role").first,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "pronoun": pronoun,
        "bio": bio,
        "profile-pic": avatar,
        "location": location,
        "link": link,
        "age": age,
        "eco-points": ecoPoints,
        "ventures": ventures,
        "followers": followers,
        "following": following,
        "role": [role],
      };

  User toEntity() => User(
        name: name,
        email: email,
        pronoun: pronoun,
        bio: bio,
        //TODO: Update it to read the specific image avatar from the assets
        avatar: "assets/images/avatar.png",
        location: location,
        link: link,
        age: age,
        ecoPoints: ecoPoints,
        ventures: ventures,
        followers: followers,
        following: following,
        role: role,
      );

  @override
  List<Object?> get props => [name, email];
}
