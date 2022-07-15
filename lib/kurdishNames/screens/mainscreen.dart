import 'package:flutter/material.dart';
import 'package:kurdish_names/kurdishNames/screens/mainscreen_for_kurdish_names_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetxController(),
    );
  }
}
