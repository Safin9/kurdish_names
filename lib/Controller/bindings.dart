import 'package:get/get.dart';
import 'package:kurdish_names/Controller/get_class.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(Counter());
  }
}
