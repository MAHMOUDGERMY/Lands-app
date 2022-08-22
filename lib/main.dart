import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:states/SM/cubit.dart';
import 'package:states/SM/states.dart';
import 'package:states/components.dart';
import 'package:states/views/Home.dart';
import 'package:states/views/Login.dart';
import 'package:states/views/Signup.dart';
import 'package:states/views/Splash.dart';

import 'firebase_options.dart';
import 'network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();

  bool? isSplash = CacheHelper.getData(key: "splash");
  bool? isDark = CacheHelper.getData(key: "isDark");
  User? isLogin = FirebaseAuth.instance.currentUser;

  Widget? widget;

  if (isSplash == true) {
    if (isLogin != null) {
      widget = const Home();
    } else {
      widget = Login();
    }
  } else {
    widget = const Splash();
  }
  print(isLogin);

  runApp(MyApp(
    isDark: isDark,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget;

  const MyApp({super.key, this.isDark, this.widget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StateCubit()
        ..getLands()
        ..getMyLands()
        ..getUserData()
        ..Mode(fromShared: isDark),
      child: BlocConsumer<StateCubit, StatesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'States App',
              debugShowCheckedModeBanner: false,
              themeMode: StateCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: light,
              darkTheme: dark,
              routes: {"home": (context) => Home()},
              home: widget,
            );
          }),
    );
  }
}
