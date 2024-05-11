import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final String uid;
  const FetchProfileEvent({required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
