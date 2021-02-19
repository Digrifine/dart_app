import 'package:http/http.dart' as http;
import 'Liquids.dart';

class Services {
  static const String url =
      "https://github.com/Digrifine/dart_app/blob/main/assets/liquid.json";

  static Future<List<Liquid>> getLiquids() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Liquid> liquid = liquidFromJson(response.body);
        return liquid;
      }
    } catch (e) {
      return List<Liquid>();
    }
  }
}
