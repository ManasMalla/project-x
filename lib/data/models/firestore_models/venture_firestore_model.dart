import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socialpreneur/data/failure.dart';
import 'package:socialpreneur/data/models/firestore_models/firestore_object_model.dart';
import 'package:socialpreneur/data/models/venture_model.dart';
import 'package:socialpreneur/domain/entity/venture.dart';

class VentureFirestoreModel
    extends FirestoreObjectModel<VentureModel, Venture> {
  @override
  VentureModel fromEntity(Venture entity) {
    return VentureModel(
      name: entity.name,
      description: entity.description,
      logo: entity.logo,
      cover: entity.cover,
      tagline: entity.tagline,
      isVerified: entity.isVerified,
      stage: entity.stage,
      category: entity.category,
      targetAudience: entity.targetAudience,
      joinedDate: entity.joinedDate,
      activeUsers: entity.activeUsers,
      problemStatement: entity.problemStatement,
      goals: entity.goals,
      features: entity.features,
      marketSizing: entity.marketSizing,
      competitors: entity.competitors,
    );
  }

  @override
  Future<Either<Failure, VentureModel>> getModelFromDocumentSnapshot(
      DocumentSnapshot<Object?> documentSnapshot) async {
    return Right(VentureModel.fromDocumentSnapshot(documentSnapshot));
  }

  @override
  Venture toEntity(VentureModel model) => model.toEntity();

  @override
  Map<String, dynamic> toJson(VentureModel data) => data.toJson();
}
