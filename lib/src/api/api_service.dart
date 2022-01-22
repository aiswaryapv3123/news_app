
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/src/models/get_news_data.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getArticle() async {

    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': '9edb712066614c51a87fbb48a0570110'
    };

    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    print("Data");
    print(body.toString());
    List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}