import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socialpreneur/domain/entity/user.dart';

import '../../failure.dart';
import '../user_model.dart';
import 'firestore_object_model.dart';

class UserFirestoreModel implements FirestoreObjectModel<UserModel, User> {
  @override
  Future<Either<Failure, UserModel>> getModelFromDocumentSnapshot(
      DocumentSnapshot snapshot) async {
    final ventures = snapshot['ventures'] as List<dynamic>;
    final followers = snapshot['followers'] as List<dynamic>;
    final following = snapshot['following'] as List<dynamic>;
    final mappedVentures = await Future.wait(ventures.map(
      (e) async => await e.get() as DocumentSnapshot,
    ));
    final mappedFollowers = await Future.wait(followers.map(
      (e) async => await e.get() as DocumentSnapshot,
    ));
    final mappedFollowing = await Future.wait(following.map(
      (e) async => await e.get() as DocumentSnapshot,
    ));
    return Right(UserModel.fromDocumentSnapshot(snapshot, mappedVentures, mappedFollowers, mappedFollowing));
  }

  @override
  Map<String, dynamic> toJson(UserModel data) => data.toJson();

  @override
  User toEntity(UserModel model) => model.toEntity();

  @override
  UserModel fromEntity(User entity) => UserModel(
      name: entity.name,
      email: entity.email,
      pronoun: entity.pronoun,
      bio: entity.bio,
      avatar: 0,
      location: entity.location,
      link: entity.link,
      age: entity.age,
      ecoPoints: entity.ecoPoints,
      ventures: entity.ventures,
      followers: entity.followers,
      following: entity.following,
      role: entity.role);
}
