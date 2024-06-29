import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logintest/views/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LoginTest());
}

class LoginTest extends StatelessWidget {
  const LoginTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
