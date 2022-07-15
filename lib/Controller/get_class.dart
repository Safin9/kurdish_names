import 'package:get/get.dart';

class Counter extends GetxController {
  RxInt counet = 0.obs;
  void increament() => counet++;
  void decreament() => counet--;
  void zero() => counet.value = 0;
}
