import 'package:flutter/material.dart';
import 'package:kurdish_names/kurdishNames/screens/kurdish_names_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KurdishNamesView(),
    );
  }
}
