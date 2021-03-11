import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/animation.dart';
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/helper/news.dart';
import 'package:shortnews/model/article_model.dart';
import 'package:shortnews/widgets/blog_tile.dart';
import 'package:shortnews/widgets/custom_actionbar.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class NewsScreen extends StatefulWidget {
  final String title;
  final List<ArticleModel> list;
  final bool isCategory;

  const NewsScreen({Key key, this.title, this.list, @required this.isCategory})
      : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<ArticleModel> _articles = new List();
  bool _loading = true;
  bool _actionBar = true;
  String _title = 'My Feed';

//  bool _isDark = Constants.isDark;

  @override
  void initState() {
    hideActionBar();
    if (widget.isCategory) {
      _loading = true;
      _title = widget.title.toUpperCase();
      getCategoryNewz();
    } else {
      _articles = widget.list;
      _loading = false;
    }
    super.initState();
  }

  hideActionBar() {
    Future.delayed(Duration(seconds: 3)).then((value) => {
          if (this.mounted)
            setState(() {
              _actionBar = false;
            })
        });
  }

  getCategoryNewz() async {
    CategoryNewsClass categoryNewsClass = CategoryNewsClass();
    await categoryNewsClass.getNews(widget.title);
    _articles.clear();
    _articles = categoryNewsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: Text(
                'Loading...',
                style: Constants.regularDarkText,
              ),
            )
          : Container(
              color: Constants.isDark ? Colors.black : Colors.white,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_actionBar) {
                          _actionBar = false;
                          return;
                        }
                        _actionBar = true;
                        hideActionBar();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30),
                      child: TransformerPageView(
                        transformer: new DeepthPageTransformer(),
                        key: PageStorageKey(widget.key),
                        physics: ClampingScrollPhysics(),
                        itemCount: _articles.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            isDark: false,
                            url: _articles[index].url,
                            imageUrl: _articles[index].urlToImage,
                            title: _articles[index].title,
                            description: _articles[index].description,
                          );
                        },
                      ),
                    ),
                  ),
                  _actionBar
                      ? CustomActionBar(
                          leftButtonName: 'Category',
                          text: _title,
                          hasDarkMode: false,
                          hasRightButton: false,
                          rightButtonTap: () {
                            setState(() {
                              Constants.isDark = true;
                            });
                          },
                        )
                      : Opacity(opacity: 0)
                ],
              ),
            ),
    );
  }
}
