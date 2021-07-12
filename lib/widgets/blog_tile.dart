import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/views/article_view.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  BlogTile({
    @required this.imageUrl,
    @required this.description,
    @required this.title,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      height: double.infinity,
      width: double.infinity,
      child: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Constants.radius),
                  topRight: Radius.circular(Constants.radius)),
              child: FadeInImage.assetNetwork(
                image: imageUrl,
                placeholder: 'assets/images/placeholder.png',
                height: 310,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
                child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 12, left: 15, right: 15),
              child: Column(
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: Constants.regularHeading,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(description,
                        softWrap: true, style: Constants.blogDescriptionText),
                  )
                ],
              ),
            )),
            Container(
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.radius),
                    bottomRight: Radius.circular(Constants.radius)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Constants.radius),
                        bottomRight: Radius.circular(Constants.radius)),
                    child: FadeInImage.assetNetwork(
                      image: imageUrl,
                      width: double.infinity,
                      placeholder: 'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Constants.radius),
                        bottomRight: Radius.circular(Constants.radius)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black12.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticleView(
                                          blogUrl: url,
                                        )));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Read More",
                              style: Constants.regularLightText,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: VerticalDivider(
                          thickness: 0.8,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            print('clicked');
                            final RenderBox box = context.findRenderObject();
                            final String textToBeShare =
                                '$title - see more: $url';
                            Share.share(textToBeShare,
                                subject: 'See this',
                                sharePositionOrigin: box.localToGlobal(
                                      Offset.zero,
                                    ) &
                                    box.size);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Share",
                              style: Constants.regularLightText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void shareNews(BuildContext context, String url, String title) {
    final RenderBox box = context.findRenderObject();
    final String textToBeShare = '$title - see more: $url';
    Share.share(textToBeShare,
        subject: 'See this',
        sharePositionOrigin: box.localToGlobal(
              Offset.zero,
            ) &
            box.size);
  }
}
