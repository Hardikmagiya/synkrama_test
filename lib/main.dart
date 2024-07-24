import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/presentation/auth/login/login_view.dart';
import 'package:untitled/presentation/bottom_tab/tab_bloc/tab_bloc.dart';
import 'package:untitled/utils/strings_utils.dart';

import 'firebase_option/firebase_option.dart';
import 'presentation/auth/login/login_cubit/auth_bloc.dart';
import 'utils/app_constants.dart';
import 'utils/shared_prefrence_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: Platform.isIOS ? 'Synkrama Test' : null, options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 814),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TabBloc()),
              BlocProvider(
                create: (_) => AuthBloc(localStorageService)..checkAuth(),
              ),
            ],
            child: MaterialApp(
              title: strAppName,
              navigatorKey: rootNavigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginView(),
            ),
          );
        });
  }
}
