import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpreneur/domain/entity/user.dart';
import 'package:socialpreneur/domain/usecase/firestore_usecase.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreUsecase<User> profileUsecase;

  ProfileBloc({required this.profileUsecase}) : super(FetchingProfileState()) {
    on<FetchProfileEvent>((event, emit) async {
      final result = await profileUsecase.getData(event.uid);
      result.fold(
          (failure) => emit(
                ErrorProfileState(message: failure.message),
              ), (user) {
        emit(
          FetchedProfileState(user: user),
        );
      });
    });
  }
}
