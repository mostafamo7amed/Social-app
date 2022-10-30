import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/observer/blocObserver.dart';
import 'package:social_app/styles/styles.dart';
import 'layout/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget startWidget;
  if(CacheHelper.getData(key: 'uid')!=null){
    uid = CacheHelper.getData(key: 'uid');
  }
  if(uid.isNotEmpty){
    startWidget = const HomeScreen();
  }else{
    startWidget = LoginScreen();
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(startWidget:startWidget ,));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({required this.startWidget,super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUser()..getPosts()..getComments(),
      child: MaterialApp(
        title: 'Social App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}