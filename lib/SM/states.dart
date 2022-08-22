abstract class StatesStates {}

class StatesInitialState extends StatesStates {}

class StatesModeState extends StatesStates {}

class StatesNavigationState extends StatesStates {}

class RegisterLoadingState extends StatesStates {}

class RegisterErrorState extends StatesStates {
  final String? error;

  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends StatesStates {}

class CreateUserErrorState extends StatesStates {
  final String? error;

  CreateUserErrorState(this.error);
}

class LoginLoadingState extends StatesStates {}

class LoginSuccessState extends StatesStates {}

class LoginErrorState extends StatesStates {
  final String? error;

  LoginErrorState(this.error);
}

class IsCheckedState extends StatesStates {}

class IsVisibleState extends StatesStates {}

class SignOutSuccess extends StatesStates {}

class GetUserDataSuccess extends StatesStates {}

class GetLandsLoadingState extends StatesStates {}

class GetLandsSuccessState extends StatesStates {}

class GetLandsErrorState extends StatesStates {}

class PickImagesLoadingState extends StatesStates {}

class PickImagesSuccessState extends StatesStates {}

class PickImagesErrorState extends StatesStates {}

class AddLandLoadingState extends StatesStates {}

class AddLandSuccessState extends StatesStates {}

class AddLandErrorState extends StatesStates {}

class ResetPasswordSuccessState extends StatesStates {}

class ResetPasswordErrorState extends StatesStates {}

class UpdateUserLoadingState extends StatesStates {}

class UpdateUserSuccessState extends StatesStates {}

class UpdateUserErrorState extends StatesStates {}

class GetMyLandsLoadingState extends StatesStates {}

class GetMyLandsSuccessState extends StatesStates {}

class GetMyLandsErrorState extends StatesStates {}
class RemoveLandSuccess extends StatesStates {}