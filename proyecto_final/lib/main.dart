import 'package:flutter/material.dart';
import 'package:proyecto_final/src/pages/home.dart';
import 'package:proyecto_final/src/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo :)hola',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (BuildContext context) => const LoginPage(),
      },
    );
  }
}
