import 'package:dartz/dartz.dart';
import 'package:socialpreneur/data/callbacks.dart';
import 'package:socialpreneur/data/failure.dart';

abstract class FirestoreRepository<T> {
  Future<Either<Failure, T>> getData(String documentId);
  Future<Either<Failure, void>> putData(T data,
      {String? documentId,
      required OnSuccessCallbackListener onSuccessCallbackListener});
  Future<Either<Failure, void>> updateData(String documentId, T data,
      {required OnSuccessCallbackListener onSuccessCallbackListener});

  Future<Either<Failure, List<T>>> queryData(String key, String value);

  Future<Either<Failure, int>> queryDataCount(String key, String value);

  Future<Either<Failure, bool>> queryIfDocumentExists(String key);
}
