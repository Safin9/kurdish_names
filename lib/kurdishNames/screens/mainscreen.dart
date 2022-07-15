import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kurdish_names/Controller/bindings.dart';
import 'package:kurdish_names/kurdishNames/screens/kurdish_names_view.dart';
import 'package:kurdish_names/kurdishNames/screens/mainscreen_for_kurdish_names_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Bind(),
      debugShowCheckedModeBanner: false,
      home: const KurdishNamesView(),
    );
  }
}
