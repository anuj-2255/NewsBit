import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/helper/news.dart';
import 'package:shortnews/model/article_model.dart';
import 'package:shortnews/widgets/blog_tile.dart';
import 'package:shortnews/widgets/search_bar.dart';
import 'package:shortnews/widgets/search_result_tile.dart';

class SearchActivity extends StatefulWidget {
  @override
  _SearchActivityState createState() => _SearchActivityState();
}

class _SearchActivityState extends State<SearchActivity> {
  List<ArticleModel> _searchResult = new List();
  String _searchString = "";
  bool _isSearching = false;
  bool _isSearchResultEmpty = false;

  getSearch(String searchString) async {
    SearchNews searchNews = SearchNews();
    await searchNews.getSearchResult(searchString);
    _searchResult = searchNews.searchList;
    if (_searchResult == null || _searchResult.isEmpty) {
      _isSearchResultEmpty = true;
    }
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: SearchBar(
                    onSubmit: (value) {
                      setState(() {
                        _searchString = value.toLowerCase();
                        _isSearching = true;
                        getSearch(_searchString);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: (_searchString.isEmpty)
                ? Center(
                    child: Text(
                      'Search result',
                      style: Constants.regularDarkText,
                    ),
                  )
                : _isSearching
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _isSearchResultEmpty
                        ? Center(
                            child: Text(
                              'Try another',
                              style: Constants.regularDarkText,
                            ),
                          )
                        : SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              key: PageStorageKey(widget.key),
                              physics: BouncingScrollPhysics(),
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index) {
                                return SearchResultTile(
                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlogTile(
                                                imageUrl: _searchResult[index]
                                                    .urlToImage,
                                                description:
                                                    _searchResult[index]
                                                        .description,
                                                title:
                                                    _searchResult[index].title,
                                                url: _searchResult[index].url,
                                                isDark: false)));
                                  },
                                  title: _searchResult[index].title,
                                  imageUrl: _searchResult[index].urlToImage,
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
