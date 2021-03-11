import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final String title, imageUrl;
  final Function onClick;

  const SearchResultTile({Key key, this.title, this.imageUrl, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              child: FadeInImage.assetNetwork(
                image: imageUrl,
                placeholder: 'assets/images/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Container(
                height: 65,
                padding:
                    EdgeInsets.only(top: 5, left: 13, right: 13, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Divider(
                      height: 0.5,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
