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
  int? limitization;
  bool isLiked = false;
  bool isVoteUp = false, isVoteDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              limitName = limitization!;
            });
          },
          label: const Text('Limitization')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              SizedBox(
                width: 115,
                child: myElevatedButton(
                  icon: genderIcon,
                  label: gender,
                  color: genderColor,
                  onPressed: () => setState(() {
                    genderType == 'M' ? genderType = 'F' : genderType = 'M';
                    (genderIcon == Icons.male)
                        ? genderIcon = Icons.female
                        : genderIcon = Icons.male;
                    (gender == 'Male') ? gender = 'Female' : gender = 'Male';
                    genderColor == Colors.blue
                        ? genderColor = Colors.pink
                        : genderColor = Colors.blue;
                  }),
                ),
              ),
            ],
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Kurdish Names'),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Limit',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      limitization = int.parse(value);
                    } else {
                      limitization = 20;
                    }
                  }),
            ),
            Expanded(
              child: SizedBox(
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
                      child: Scrollbar(
                        interactive: true,
                        trackVisibility: true,
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ListView.builder(
                          itemCount: snapshot.data!.names.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.names[index];
                            return ExpansionTile(
                              leading: Text(data.positive_votes.toString()),
                              trailing: SelectableText(data.nameId.toString()),
                              title: Text(data.name),
                              children: [
                                Text((data.desc == '')
                                    ? 'No Description'
                                    : data.desc),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    myElevatedButton(
                                      color: Colors.blue,
                                      icon: isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      label: (isVoteUp) ? 'Voted' : 'Vote',
                                      onPressed: () {
                                        setState(
                                          () {
                                            isLiked = !isLiked;
                                            isVoteUp = !isVoteUp;
                                            kurdishnames.voting(
                                                nameId: data.nameId,
                                                isVoteUp: true);
                                          },
                                        );
                                      },
                                    ),
                                    myElevatedButton(
                                      color: Colors.red,
                                      icon: isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      label: (isVoteDown) ? 'Voted' : 'Vote',
                                      onPressed: () {
                                        setState(
                                          () {
                                            isVoteDown = !isVoteDown;
                                            isLiked = !isLiked;
                                            kurdishnames.voting(
                                                nameId: data.nameId,
                                                isVoteUp: false);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
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

  ElevatedButton myElevatedButton({
    required IconData icon,
    required String label,
    required GestureTapCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
    );
  }
}
