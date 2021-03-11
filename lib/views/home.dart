import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortnews/helper/constants.dart';
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
  bool _activeDialog = false;

  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;

  @override
  initState() {
    _checkInternet();
    super.initState();
  }

  getNewz() async {
    News newsclass = News();
    await newsclass.getNews();
    _articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  _checkInternet() async {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        _activeDialog = true;
        _loading = false;
        _showdailog();
      } else if (_previousResult == ConnectivityResult.none) {
        checkConnection().then((value) {
          if (value == true) {
            if (_activeDialog == true) {
              _activeDialog = false;
              Navigator.pop(context);
            }
          }
        });
      } else if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        getNewz();
      }
      _previousResult = connectivityResult;
    });
  }

  Future<bool> checkConnection() async {
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty ||
            result == null) {
          return Future.value(true);
        } else {
          _loading = false;
          return Future.value(false);
        }
      }).catchError((error) {
        _loading = false;
        return Future.value(false);
      });
    } on SocketException catch (_) {
      _loading = false;
      return Future.value(false);
    }
  }

  void _showdailog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Error',
                style: Constants.regularHeading,
              ),
              content: Text('No Internet Detected'),
              actions: [
                FlatButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeListMethod('SystemNavigator.pop');
                    },
                    child: Text('Exit'))
              ],
            ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
      initialPage: _selectedPage,
    );
    return Scaffold(
      //backgroundColor: Constants.isDark ? Colors.black87 : Colors.white,
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
