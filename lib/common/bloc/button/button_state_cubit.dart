import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/common/bloc/button/button_state.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitial());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) => emit(ButtonFailure(error: error.toString())), (success) => emit(ButtonSuccess()));
    } catch (error) {
      emit(ButtonFailure(error: error.toString()));
    }
  }

  void executeNonEither({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    try {
      await usecase.call(param: params);
      emit(ButtonSuccess());
    } catch (error) {
      emit(ButtonFailure(error: error.toString()));
    }
  }
}
