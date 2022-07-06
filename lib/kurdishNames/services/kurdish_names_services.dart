import 'package:http/http.dart' as http;
import 'package:kurdish_names/kurdishNames/model/classs_model.dart';

class KurdishNameService {
  Future<KurdishNamesModel> fetchdata() async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {'limit': '50', 'offset': '0', 'gender': 'F'});

    // var uri1 = "https://nawikurdi.com/api?limit=5&gender=F&offset=0";
    http.Response response =
        await http.get(uri).catchError((err) => print(err));
    KurdishNamesModel kurdishNames = KurdishNamesModel.fromJson(response.body);
    return kurdishNames;
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
