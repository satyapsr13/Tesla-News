// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla_news/modal/newsmodel.dart';
import 'package:tesla_news/provider/newsapi.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String title = "title";
  @override
  void initState() {
    super.initState();
  }

  List<Articles> articles = [];
  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2021-09-13&sortBy=publishedAt&apiKey=711705ab4962418cb902c9a4b83364ba'));
    log(response.statusCode.toString());
    var body = json.decode(response.body).cast<Map<String, dynamic>>();

    Articles dummyarticles;
    for (var item in body["articles"]) {
      dummyarticles = item;
      articles.add(dummyarticles);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<NewsProvider>(context).fetchArticles();
        return Scaffold(
      appBar: AppBar(
        title: const Text('Tesla News'),
      ),
      // body: ListView.builder(
      //     itemCount: list.length,
      //     itemBuilder: (ctx, index) => Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(list[index].description),
      //         )),
      body: FutureBuilder(
        future: fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const AllDone();
          }
          return Container();
        },
      ),
      //floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
  }
}

class AllDone extends StatelessWidget {
  const AllDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NewsProvider>(context).articles;
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data[index].description),
        ));
  }
}
