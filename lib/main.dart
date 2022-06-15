import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pomodoro/controllers/pomodoro_controller.dart';
import 'package:minimal_pomodoro/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(PomodoroController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 23, 18, 32),
      ),
      home: const HomeScreen(),
    );
  }
}
