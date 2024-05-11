import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpreneur/data/models/venture_model.dart';
import 'package:socialpreneur/data/repositories/firestore_repository_impl.dart';
import 'package:socialpreneur/domain/entity/user.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/domain/usecase/firestore_usecase.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_state.dart';
import 'package:socialpreneur/presentation/bloc/venture_module/fetch_venture_event.dart';
import 'package:socialpreneur/presentation/bloc/venture_module/venture_state.dart';
import 'package:socialpreneur/presentation/injector.dart';

class FetchVentureBloc extends Bloc<FetchVentureEvent, FetchVentureState> {
  FetchVentureBloc() : super(FetchingVenturesState()) {
    on<FetchVentureEvent>((event, emit) async {
      await Injector.firestore.collection('ventures').get().then((value) async {
        try {
          final ventures = await value.docs
              .map((e) => VentureModel.fromDocumentSnapshot(e).toEntity())
              .toList();
          emit(FetchedVenturesState(ventures: ventures));
        } on Exception catch (e) {
          emit(ErrorFetchingVenturesState(message: e.toString()));
        }
      });
    });
  }
}
