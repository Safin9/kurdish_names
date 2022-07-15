import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kurdish_names/kurdishNames/screens/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storage.initStorage;
  runApp(const MainScreen());
}

final storage = GetStorage();
