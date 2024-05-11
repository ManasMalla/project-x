import 'package:equatable/equatable.dart';
import 'package:socialpreneur/domain/entity/user.dart';
import 'package:socialpreneur/domain/entity/venture.dart';

class FetchVentureState extends Equatable {
  const FetchVentureState();
  @override
  List<Object?> get props => [];
}

class FetchingVenturesState extends FetchVentureState {}

class FetchedVenturesState extends FetchVentureState {
  final List<Venture> ventures;
  const FetchedVenturesState({required this.ventures});
  @override
  // TODO: implement props
  List<Object?> get props => [ventures];
}

class ErrorFetchingVenturesState extends FetchVentureState {
  final String message;
  const ErrorFetchingVenturesState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
