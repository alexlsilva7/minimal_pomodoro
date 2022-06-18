import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pomodoro/components/cronometro.dart';
import 'package:minimal_pomodoro/screens/home_screen/widget/settings_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal Pomodoro',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
              iconSize: 20,
              onPressed: () {
                // Get.to(() => const SettingsScreen());
                Get.bottomSheet(const SettingsBottomSheet());
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white.withOpacity(0.9),
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(child: Cronometro()),
        ],
      ),
    );
  }
}
