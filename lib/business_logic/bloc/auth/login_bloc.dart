import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/data/repositories/auth_repo.dart';
import 'package:pizza/utils/formatters/formatter.dart';
import 'package:pizza/utils/logging/logger.dart';

// Define events
abstract class LoginEvent {}

class PhoneLoginEvent extends LoginEvent {
  final String phoneNumber;
  final String password;

  PhoneLoginEvent({
    required this.phoneNumber,
    required this.password,
  });
}

class GoogleLoginEvent extends LoginEvent {}

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
    on<PhoneLoginEvent>((PhoneLoginEvent event, emit) async {
      emit(LoginLoading());
      try {
        await Future.delayed(const Duration(seconds: 3));
        await authRepository.signInWithEmailAndPassword(
            TFormatter.convertPhoneNumberToEmail(event.phoneNumber), event.password);

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
    on<GoogleLoginEvent>((GoogleLoginEvent event, emit) async {
      try {
        await authRepository.signInWithGoogle();
        TLoggerHelper.info('Google login');
      } catch (e) {
        TLoggerHelper.info(e.toString());
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
