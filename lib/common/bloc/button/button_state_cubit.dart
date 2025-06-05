import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitial());

  // use when usecase return Either
  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) => emit(ButtonFailure(error: error.toString())), (success) => emit(ButtonSuccess()));
    } catch (error) {
      emit(ButtonFailure(error: error.toString()));
    }
  }

  // use for local
  void executeNonEither({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    try {
      await usecase.call(param: params);
      emit(ButtonSuccess());
    } catch (error) {
      emit(ButtonFailure(error: error.toString()));
    }
  }

  // use this if you want to use callback
  void executeCallback(Future<void> Function() callback) async {
    emit(ButtonLoading());
    try {
      await callback();
      emit(ButtonSuccess());
    } catch (error) {
      emit(ButtonFailure(error: error.toString()));
    }
  }
}
