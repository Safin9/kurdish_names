import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdish_names/kurdishNames/model/classs_model.dart';
import 'package:kurdish_names/kurdishNames/services/kurdish_names_services.dart';
import 'package:kurdish_names/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;
  late Future<bool> _isThis;
  @override
  void initState() {
    // TODO: implement initState
    _counter = _prefs.then((prefs) => prefs.getInt('counter') ?? 0);
    _isThis = _prefs.then((value) => value.getBool('isThis') ?? false);
    super.initState();
  }

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);
    setState(() {
      _counter = _prefs.then((prefs) => prefs.getInt('counter') ?? 0);
    });
  }

  Future<void> isThisFunction() async {
    final SharedPreferences pref = await _prefs;
    final bool isThis = (pref.getBool('isThis') ?? false) ? false : true;
    pref.setBool('isThis', isThis);
    setState(() {
      _isThis = _prefs.then(((value) {
        return value.getBool('isThis') ?? false;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              kurdishnames.name = null;
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
                    kurdishnames.name = null;
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
      body: Stack(
        children: [
          SizedBox(
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
                      future: kurdishnames.name != null
                          ? null
                          : kurdishnames.fetchdata(
                              limit: limitName, genderType: genderType),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                bool? isLiked = storage.read('p${data.nameId}');
                                bool? disLikeed =
                                    storage.read('n${data.nameId}');
                                return ExpansionTile(
                                  leading: Text(data.positive_votes.toString()),
                                  trailing:
                                      SelectableText(data.nameId.toString()),
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
                                          icon: (isLiked == true)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          label: (isLiked == true)
                                              ? 'Voted'
                                              : 'Vote',
                                          onPressed: () async {
                                            await kurdishnames.voting(
                                                nameId: data.nameId,
                                                isVoteUp: true);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text('is voted'),
                                            ));
                                            setState(
                                              () {},
                                            );
                                          },
                                        ),
                                        myElevatedButton(
                                          color: Colors.red,
                                          icon: disLikeed == false
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          label: (disLikeed == false)
                                              ? 'Voted'
                                              : 'Vote',
                                          onPressed: () async {
                                            await kurdishnames.voting(
                                                nameId: data.nameId,
                                                isVoteUp: false);
                                            setState(
                                              () {},
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
          Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    child: FutureBuilder(
                        future: _counter,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error'),
                            );
                          }
                          return Text(snapshot.data.toString());
                        }),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: isThisFunction,
                    child: FutureBuilder(
                        future: _isThis,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error'),
                            );
                          }
                          return Text(snapshot.data.toString());
                        }),
                  ),
                ],
              ))
        ],
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
