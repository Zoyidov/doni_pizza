import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/data/model/mymodels/user_model.dart';
import 'package:pizza/data/repositories/auth_repo.dart';
import 'package:pizza/data/repositories/user_repo.dart';
import 'package:pizza/utils/formatters/formatter.dart';
import 'package:pizza/utils/logging/logger.dart';

// Define events
abstract class RegistrationEvent {}

class RegisterEvent extends RegistrationEvent {
  final String name;
  final String phoneNumber;
  final String password;

  RegisterEvent({
    required this.name,
    required this.phoneNumber,
    required this.password,
  });
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

// Create the BLoC
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  RegistrationBloc(this.authRepository, this.userRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>((RegisterEvent event, Emitter emit) async {
      emit(RegistrationLoading());
      try {
        TLoggerHelper.info(event.phoneNumber);
        TLoggerHelper.info(TFormatter.convertPhoneNumberToEmail(event.phoneNumber));
        final User? authUser = await authRepository.registerWithEmailAndPassword(
            TFormatter.convertPhoneNumberToEmail(event.phoneNumber), event.password);
        final user = UserModel(
          id: authUser!.uid,
          name: event.name,
          phoneNumber: event.phoneNumber,
          imageUrl: '',
          password: event.password,
        );
        await userRepository.storeUserData(user);
        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });
  }
}
