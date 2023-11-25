import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../Pages/login.dart';
import 'package:flutter/material.dart';
import 'Models/feedback_model.dart';
import 'Pages/home.dart';

void main() async{
  await Hive.initFlutter();

  // Register the Hive adapters here
  Hive.registerAdapter(FeedbackModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bundesliga Teams',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}