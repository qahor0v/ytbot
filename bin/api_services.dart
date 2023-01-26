import 'package:http/http.dart';

import 'constants.dart';

class APIServices {
  static String base = "youtube-mp36.p.rapidapi.com";
  static String path = "/dl";


  static Future<String?> getData(String url) async {
    final params = {
      "id": url.split("be/").last,
    };

    var uri = Uri.https(base, path, params);

    var response = await get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    }

    return null;
  }
}
