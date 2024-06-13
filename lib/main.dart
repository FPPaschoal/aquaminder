import 'package:AquaMinder/View/about_view.dart';
import 'package:AquaMinder/View/forgot_password_view.dart';
import 'package:AquaMinder/View/initial_view.dart';
import 'package:AquaMinder/View/sign_up_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:AquaMinder/View/sign_in_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //
  // Firebase
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaMinder',
      initialRoute: 'login',
      routes: {
        'login': (context) => const SignInView(),
        'cadastrar': (context) => const SignUpView(),
        'principal': (context) => const InitialView(),
        'sobre': (context) => const AboutView(),
        'redefinirSenha': (context) => const ForgotPasswordView(),
      },
    );
  }
}
