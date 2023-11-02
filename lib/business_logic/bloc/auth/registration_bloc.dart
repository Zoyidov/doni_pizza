import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/data/repositories/auth_repo.dart';

// Define events
abstract class RegistrationEvent {}

class RegisterEvent extends RegistrationEvent {
  final String name;
  final String phoneNumber;
  final String password;

  RegisterEvent(this.name, this.phoneNumber, this.password);
}

// Define states
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure(this.error);
}

class RegistrationCodeSent extends RegistrationState {
  final String verificationId;
  final int? resendToken;

  RegistrationCodeSent(this.verificationId, this.resendToken);
}

class RegistrationAutoRetrievalTimeout extends RegistrationState {
  final String verificationId;
  RegistrationAutoRetrievalTimeout(this.verificationId);
}

// Create the BLoC
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;
  FirebaseAuth auth = FirebaseAuth.instance;

  RegistrationBloc(this.authRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>((RegisterEvent event, Emitter emit) async {
      emit(RegistrationLoading());
      try {
        print(event.phoneNumber);
        final result = await authRepository.signInWithPhoneNumber(
          phoneNumber: event.phoneNumber,
          codeSent: (String verificationId, int? resendToken) {
            emit(RegistrationCodeSent(verificationId, resendToken));
          },
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
            // emit(RegistrationFailure(e.toString()));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            emit(RegistrationAutoRetrievalTimeout(verificationId));
          },
        );

        if (result != null) {
          // Handle success or further actions if needed
          emit(RegistrationSuccess());
        }
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });
  }
}
