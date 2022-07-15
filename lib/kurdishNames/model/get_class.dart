import 'package:get/get.dart';

class Counter extends GetxController {
  var counet = 0.obs;
  void increament() => counet++;
  void decreament() => counet--;
}
