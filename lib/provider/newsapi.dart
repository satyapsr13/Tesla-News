import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tesla_news/modal/newsmodel.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  List<Articles> articles = [];
  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2021-09-13&sortBy=publishedAt&apiKey=711705ab4962418cb902c9a4b83364ba'));
    log(response.statusCode.toString());
print("+++++++++|||||||||||||||||||||||||||||||||||+++++++++++++++++");
    // print("$  ");
print("+++++++++|||||||||||||||||||||||||||||||||||+++++++++++++++++");
   
    // var body = json.decode(response.body).cast<Map<String, dynamic>>();
    // log(body);
    // Articles dummyarticles;
    // for (var item in body["articles"]) {
    //   dummyarticles = item;
    //   articles.add(dummyarticles);
    // }

    notifyListeners();
    log(articles.length.toString());
  }
}
