import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialpreneur/data/models/firestore_models/firestore_object_model.dart';
import 'package:socialpreneur/data/models/firestore_models/user_firestore_object_model.dart';
import 'package:socialpreneur/data/models/user_model.dart';
import 'package:socialpreneur/data/repositories/firestore_repository_impl.dart';
import 'package:socialpreneur/domain/entity/user.dart';
import 'package:socialpreneur/domain/enums/collection_enum.dart';
import 'package:socialpreneur/domain/repositories/firestore_repository.dart';
import 'package:socialpreneur/domain/usecase/firestore_usecase.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_bloc.dart';
import 'package:socialpreneur/presentation/bloc/venture_module/venture_bloc.dart';

class Injector {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirestoreObjectModel<UserModel, User> userFirestoreObjectModel =
      UserFirestoreModel();
  static FirestoreRepository<User> userFirestoreRepository =
      FirestoreRepositoryImpl<UserModel, User>(
          firestore: firestore,
          collection: Collection.users,
          objectModel: userFirestoreObjectModel);
  static FirestoreUsecase<User> userFirestoreUseCase = FirestoreUsecase(
      collectionType: Collection.users,
      firestoreRepository: userFirestoreRepository);

  static ProfileBloc profileBloc =
      ProfileBloc(profileUsecase: userFirestoreUseCase);
  static FetchVentureBloc fetchVentureBloc = FetchVentureBloc();
}
