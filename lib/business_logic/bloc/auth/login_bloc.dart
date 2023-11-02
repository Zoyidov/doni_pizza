import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/data/repositories/auth_repo.dart';

// Define events
abstract class LoginEvent {}

class PhoneLoginEvent extends LoginEvent {
  final String phoneNumber;

  PhoneLoginEvent(this.phoneNumber);
}

// Define states
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

// Create the BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on((PhoneLoginEvent event, emit) async {
      emit(LoginLoading());
      try {
        // Call the authentication method in the AuthRepository
        // For phone authentication, it might involve OTP code verification
        // If successful, yield LoginSuccess, otherwise yield LoginFailure
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
