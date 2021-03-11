import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String Url =
      'http://newsapi.org/v2/top-headlines?country=in&apiKey=f13d32be5c2e49ecb4844d7d6bfabf30';

  static String getCategoryUrl(String category) {
    final String categoryUrl =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=f13d32be5c2e49ecb4844d7d6bfabf30';
    return categoryUrl;
  }

  static String getSearch(String keyword) {
    final String searchUrl =
        'https://newsapi.org/v2/top-headlines?country=in&q=$keyword&apiKey=f13d32be5c2e49ecb4844d7d6bfabf30';
    return searchUrl;
  }

  static bool isDark = false;

  static const double radius = 15;

  static const regularHeading = TextStyle(
      fontSize: 18.8, fontWeight: FontWeight.w500, color: Colors.black);

  static const boldHeading = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const actionBarTitle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87);

  static const blogDescriptionText = TextStyle(
      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal);

  static const regularLightText = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const searchBarText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.grey);

  static final topicText = TextStyle(
      fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w600);

  static const actionBarButtons = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 13);
}
