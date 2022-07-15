import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurdish_names/Controller/get_class.dart';

class GetxController extends StatelessWidget {
  const GetxController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Get.find<Counter>();
    return Scaffold(
      appBar: AppBar(
        title: Obx((() => Text(counter.counet.toString()))),
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FloatingActionButton(
                  onPressed: counter.decreament,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.text_decrease),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: counter.zero,
                  child: const Icon(Icons.exposure_zero),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: counter.increament,
                  child: const Icon(Icons.text_increase),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
