import 'package:http/http.dart' as http;
import 'types/wikipedia_result.dart';
import 'dart:convert';

class Wikipedia {
  final String templateUrl =
      "https://{language}.wikipedia.org/api/rest_v1/page/summary";
  final String language;
  final String userAgent;

  String get url => templateUrl.replaceAll("{language}", language);
  Wikipedia(this.language, this.userAgent);

  Future<WikipediaResult> getSummary(String title) async {
    final response = await http.get(
      Uri.parse('$url/$title'),
      headers: {'User-Agent': userAgent},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return WikipediaResult.fromJson(json);
    } else {
      throw Exception('Failed to load Wikipedia summary');
    }
  }
}
