import 'package:http/http.dart' as http;
import 'package:kurdish_names/kurdishNames/model/classs_model.dart';

class KurdishNameService {
  Future<KurdishNamesModel> fetchdata(
      {required int limit, required String genderType}) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {
          'limit': '$limit',
          'offset': '0',
          'gender': genderType
        });

    // var uri1 = "https://nawikurdi.com/api?limit=5&gender=F&offset=0";
    http.Response response =
        await http.get(uri).catchError((err) => print(err));
    KurdishNamesModel kurdishNames = KurdishNamesModel.fromJson(response.body);
    return kurdishNames;
  }

  Future voting({required int nameId, required bool isVoteUp}) async {
    var uri = Uri.parse("https://nawikurdi.com/api/vote");
    http.Response response = await http.post(uri, body: {
      "name_id": nameId.toString(),
      "uid": "iudsdj",
      "impact": isVoteUp ? "positive" : "negative"
    });
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
