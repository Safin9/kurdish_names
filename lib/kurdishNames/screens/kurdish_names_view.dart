import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdish_names/kurdishNames/model/classs_model.dart';
import 'package:kurdish_names/kurdishNames/services/kurdish_names_services.dart';

class KurdishNamesView extends StatefulWidget {
  const KurdishNamesView({Key? key}) : super(key: key);

  @override
  State<KurdishNamesView> createState() => _KurdishNamesViewState();
}

class _KurdishNamesViewState extends State<KurdishNamesView> {
  //TODO:: make this a class for the model

  //TODO: making class for kurdish names services ...

  //TODO: rendering
  KurdishNameService kurdishnames = KurdishNameService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Kurdish Names'),
            Expanded(
              child: Container(
                child: FutureBuilder<KurdishNamesModel>(
                  future: kurdishnames.fetchdata(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.names[index];
                          return ListTile(
                            title: Text(data.name),
                            subtitle: Text((data.desc == '')
                                ? 'No Description'
                                : data.desc),
                            trailing: Text(data.positive_votes.toString()),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
