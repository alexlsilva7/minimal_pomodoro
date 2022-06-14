import 'package:flutter/material.dart';

class CronometroBotao extends StatelessWidget {
  final String text;
  final IconData iconData;
  final void Function()? onTap;

  const CronometroBotao(
      {required this.text, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
      icon: Icon(iconData, color: Colors.white),
      onPressed: onTap,
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
