import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/screens/news_screen.dart';

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(categoryName);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsScreen(
                      isCategory: true,
                      title: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Constants.radius)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.radius)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black87.withOpacity(0.3),
                  ),
                ),
              ),
              Text(
                categoryName,
                style: Constants.regularLightText,
              ),
            ],
          )),
    );
  }
}
