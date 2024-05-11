import 'package:equatable/equatable.dart';
import 'package:socialpreneur/domain/entity/user.dart';

class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class FetchingProfileState extends ProfileState {}

class FetchedProfileState extends ProfileState {
  final User user;
  const FetchedProfileState({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class ErrorProfileState extends ProfileState {
  final String message;
  const ErrorProfileState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
