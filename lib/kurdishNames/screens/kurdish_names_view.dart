import 'package:flutter/material.dart';

class KurdishNamesView extends StatefulWidget {
  const KurdishNamesView({Key? key}) : super(key: key);

  @override
  State<KurdishNamesView> createState() => _KurdishNamesViewState();
}

class _KurdishNamesViewState extends State<KurdishNamesView> {
  //TODO:: make this a class for the model

  //TODO: making class for kurdish names services ...

  //TODO: rendering
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('kurdish names view'),
        ),
      ),
    );
  }
}
