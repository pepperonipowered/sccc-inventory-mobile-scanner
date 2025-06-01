abstract class AuthButtonStates {}

class ButtonInitial extends AuthButtonStates {}

class ButtonLoading extends AuthButtonStates {}

class ButtonSuccess extends AuthButtonStates {}

class ButtonFailure extends AuthButtonStates {
  final String error;

  ButtonFailure({required this.error});
}
