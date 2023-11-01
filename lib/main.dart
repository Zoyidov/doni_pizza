import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/bloc/order_bloc.dart';
import 'package:pizza/business_logic/bloc/state_bloc.dart';
import 'package:pizza/business_logic/cubit/tab_cubit.dart';
import 'package:pizza/generated/codegen_loader.g.dart';
import 'package:pizza/presentation/ui/splash_screen/splash_screen.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:provider/provider.dart';

import 'data/database/orders_database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_){
    runApp(
      EasyLocalization(
          assetLoader: const CodegenLoader(),
          supportedLocales: const [Locale('en'), Locale('ru'), Locale('uz')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
        BlocProvider(create: (context) => FoodBloc()..add(LoadTodosEvent())),
        BlocProvider(create: (context) => OrderBloc()),
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
