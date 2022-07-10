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
  String gender = 'Male';
  IconData genderIcon = Icons.male;
  Color genderColor = Colors.blue;
  String genderType = 'M';
  int limitName = 20;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: const [],
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
                  future: kurdishnames.fetchdata(
                      limit: limitName, genderType: genderType),
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
                          return ExpansionTile(
                            leading: Text(data.positive_votes.toString()),
                            trailing: Text(data.nameId.toString()),
                            title: Text(data.name),
                            children: [
                              Text((data.desc == '')
                                  ? 'No Description'
                                  : data.desc),
                              ElevatedButton.icon(
                                onPressed: () {
                                  //FIXME: add a like button

                                  setState(
                                    () {
                                      isLiked = !isLiked;
                                      kurdishnames.voting(
                                          nameId: data.nameId, isVoteUp: true);
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          genderColor),
                                ),
                                icon: isLiked
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                label: Text((isLiked) ? 'Like' : 'Liked'),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 110,
                  child: ElevatedButton.icon(
                      onPressed: () => setState(() {
                            genderType == 'M'
                                ? genderType = 'F'
                                : genderType = 'M';
                            (genderIcon == Icons.male)
                                ? genderIcon = Icons.female
                                : genderIcon = Icons.male;
                            (gender == 'Male')
                                ? gender = 'Female'
                                : gender = 'Male';
                            genderColor == Colors.blue
                                ? genderColor = Colors.pink
                                : genderColor = Colors.blue;
                          }),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(genderColor),
                      ),
                      icon: Icon(genderIcon),
                      label: Text(gender)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
