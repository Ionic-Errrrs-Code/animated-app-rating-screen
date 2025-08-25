import 'package:flutter/material.dart';
import 'screens/rate_experience_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate Your Experience',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const RateExperienceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}