import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/news.dart';
import 'package:shortnews/model/article_model.dart';
import 'package:shortnews/screens/category_screen.dart';
import 'package:shortnews/screens/news_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

PageController _pageController;
int _selectedPage = 2;

class _HomeState extends State<Home> {
  List<ArticleModel> _articles = new List();
  bool _loading = true;

  @override
  initState() {
    getNewz();
    super.initState();
  }

  getNewz() async {
    News newsclass = News();
    try {
      log('loading');
      await newsclass.getNews();
      _articles = newsclass.news;
      setState(() {
        _loading = false;
      });
    } catch (exception) {
      log('$exception');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
      initialPage: _selectedPage,
    );
    return Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView(
              controller: _pageController,
              onPageChanged: (num) {
                _pageController.animateToPage(num,
                    duration: Duration(milliseconds: 30),
                    curve: Curves.easeInCirc);
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                CategoryScreen(),
                NewsScreen(
                  isCategory: false,
                  list: _articles,
                ),
              ],
            ),
    );
  }
}
