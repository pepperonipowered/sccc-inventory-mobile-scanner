abstract class ButtonState {}

class ButtonInitial extends ButtonState {}

class ButtonLoading extends ButtonState {}

class ButtonSuccess extends ButtonState {}

class ButtonFailure extends ButtonState {
  final String error;

  ButtonFailure({required this.error});
}