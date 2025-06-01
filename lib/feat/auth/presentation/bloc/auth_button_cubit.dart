import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_button_states.dart';

class AuthButtonCubit extends Cubit<AuthButtonStates> {
  AuthButtonCubit() : super(ButtonInitial());
  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());
    await Future.delayed(Duration(milliseconds: 1500));
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) => emit(ButtonFailure(error: error.toString())), (success) {
        emit(ButtonSuccess());
      });
    } on DioException catch (error) {
      emit(ButtonFailure(error: error.response!.data['message'].toString()));
    }
  }
}
