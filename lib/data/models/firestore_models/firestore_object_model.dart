import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socialpreneur/data/failure.dart';

abstract class FirestoreObjectModel<P, Q> {
  Future<Either<Failure, P>> getModelFromDocumentSnapshot(
      DocumentSnapshot documentSnapshot);
  Map<String, dynamic> toJson(P data);
  P fromEntity(Q entity);
  Q toEntity(P model);
}
