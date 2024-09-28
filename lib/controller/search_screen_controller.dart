import 'package:api_session2/model/news_res_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  NewResModel? newsResModel;
  List<Article> newsArticles = [];
  bool isLoading = false;

  Future<void> onSearch(String keyWord) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$keyWord&apiKey=742488509a4f4f23b93e7ac3afc24cad");
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        newsResModel = newResModelFromJson(res.body);
        if (newsResModel != null) {
          newsArticles = newsResModel!.articles ?? [];
        }
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
