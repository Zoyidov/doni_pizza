import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/bloc/auth/login_bloc.dart';
import 'package:pizza/business_logic/bloc/auth/otp_verification_bloc.dart';
import 'package:pizza/business_logic/bloc/auth/registration_bloc.dart';
import 'package:pizza/business_logic/bloc/order_bloc.dart';
import 'package:pizza/business_logic/bloc/state_bloc.dart';
import 'package:pizza/business_logic/cubit/tab_cubit.dart';
import 'package:pizza/data/repositories/auth_repo.dart';
import 'package:pizza/generated/codegen_loader.g.dart';
import 'package:pizza/presentation/ui/splash_screen/splash_screen.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'data/database/orders_database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug
      // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Device Check provider
      // 3. App Attest provider
      // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
      // appleProvider: AppleProvider appAttest,
      );
  runApp(
    EasyLocalization(
        assetLoader: const CodegenLoader(),
        supportedLocales: const [Locale('en'), Locale('ru'), Locale('uz')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final AuthRepository authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
        BlocProvider(create: (context) => FoodBloc()..add(LoadTodosEvent())),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => LoginBloc(authRepository)),
        BlocProvider(create: (context) => RegistrationBloc(authRepository)),
        BlocProvider(create: (context) => OTPVerificationBloc(authRepository)),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
