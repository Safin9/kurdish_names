import 'package:http/http.dart' as http;
import 'package:kurdish_names/kurdishNames/model/classs_model.dart';
import 'package:kurdish_names/main.dart';

class KurdishNameService {
  KurdishNamesModel? name;
  Future<KurdishNamesModel> fetchdata(
      {required int limit, required String genderType}) async {
    Uri uri = Uri(
      scheme: 'https',
      host: 'nawikurdi.com',
      path: 'api',
      queryParameters: {'limit': '$limit', 'offset': '0', 'gender': genderType},
    );

    // var uri1 = "https://nawikurdi.com/api?limit=5&gender=F&offset=0";
    http.Response response =
        await http.get(uri).catchError((err) => print(err));
    name = KurdishNamesModel.fromJson(response.body);
    if (response.statusCode != 200) {
      return Future.error('Error');
    }
    return name!;
  }

// TODO: send 40 request by randoming 'uid'
  Future<void> voting({required int nameId, required bool isVoteUp}) async {
    var uri = Uri.parse("https://nawikurdi.com/api/vote");

    for (int i = 50; i < 150; i++) {
      http.Response response = await http.post(uri, body: {
        "name_id": nameId.toString(),
        "uid": "dwqdw$i",
        "impact": isVoteUp ? "positive" : "negative"
      });
      print(response.body);
      if (response.statusCode == 200) {
        if (isVoteUp) {
          await storage.write('p$nameId', true);
        } else {
          await storage.write('n$nameId', false);
        }
      }
    }
  }
}
// class KurdishNameService {
//   Future<String> fetchdata() async {
//     Uri uri = Uri(
//         scheme: 'https',
//         host: 'nawikurdi.com',
//         path: 'api',
//         queryParameters: {'limit': '5', 'offset': '0', 'gender': 'F'});  
//     http.Response response =
//         await http.get(uri).catchError((err) => print(err));
//    
//     return response.body;
//   }
// }
