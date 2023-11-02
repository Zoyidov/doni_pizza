import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/data/repositories/auth_repo.dart';

// Define events
abstract class OTPVerificationEvent {}

class VerifyOTPEvent extends OTPVerificationEvent {
  final String otpCode;
  final String verificationId;

  VerifyOTPEvent({required this.verificationId, required this.otpCode});
}

// Define states
abstract class OTPVerificationState {}

class OTPVerificationInitial extends OTPVerificationState {}

class OTPVerificationLoading extends OTPVerificationState {}

class OTPVerificationSuccess extends OTPVerificationState {}

class OTPVerificationFailure extends OTPVerificationState {
  final String error;

  OTPVerificationFailure(this.error);
}

// Create the BLoC
class OTPVerificationBloc extends Bloc<OTPVerificationEvent, OTPVerificationState> {
  final AuthRepository authRepository;

  OTPVerificationBloc(this.authRepository) : super(OTPVerificationInitial()) {
    on<VerifyOTPEvent>((VerifyOTPEvent event, emit) async {
      emit(OTPVerificationLoading());
      try {
        await authRepository.signInWithCredential(PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otpCode));
        emit(OTPVerificationSuccess());
      } catch (e) {
        emit(OTPVerificationFailure(e.toString()));
      }
    });
  }
}
