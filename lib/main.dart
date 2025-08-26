import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/rate_experience_screen.dart';
import 'theme.dart';

/// App entry point
void main() {
  runApp(const MyApp());
}

/// Root widget configuring themes and responsive sizing via ScreenUtil
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14/15 logical resolution
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'SparkJoy - Rate Your Experience',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: child,
      ),
      child: const RateExperienceScreen(),
    );
  }
}
