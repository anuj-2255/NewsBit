import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/model/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = Constants.Url;

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              //publishedAt: element['publishedAt'],
              content: element['context']);
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = Constants.getCategoryUrl(category);
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              //publishedAt: element['publishedAt'],
              content: element['context']);
          news.add(articleModel);
        }
      });
    }
  }
}

class SearchNews {
  List<ArticleModel> searchList = [];

  Future<void> getSearchResult(String keyword) async {
    String searchUrl = Constants.getSearch(keyword);
    var response = await http.get(searchUrl);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              //publishedAt: element['publishedAt'],
              content: element['context']);
          searchList.add(articleModel);
        }
      });
    }
  }
}
