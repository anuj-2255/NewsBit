import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/widgets/blog_tile.dart';

class ResultScreen extends StatelessWidget {
  final String imageUrl, title, description, url;

  const ResultScreen({
    Key key,
    this.imageUrl,
    this.title,
    this.description,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogTile(
        imageUrl: imageUrl,
        description: description,
        url: url,
        title: title,
      ),
    );
  }
}
