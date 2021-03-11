import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/constants.dart';
import 'package:shortnews/helper/data.dart';
import 'package:shortnews/model/category_model.dart';
import 'package:shortnews/screens/search_screen.dart';
import 'package:shortnews/widgets/category_tile.dart';
import 'package:shortnews/widgets/custom_actionbar.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> _categories = new List<CategoryModel>();

  @override
  void initState() {
    _categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black87,
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomActionBar(
            text: 'Discover',
            hasDarkMode: false,
            hasLeftButton: false,
            rightButtonName: 'My Feed',
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchActivity()));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              margin: EdgeInsets.only(right: 16, left: 16, top: 20, bottom: 16),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Text(
                'Search Here',
                style: Constants.searchBarText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16, bottom: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Suggested Topics',
                  style: Constants.topicText,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Divider(
                  height: 10,
                  color: Colors.black87,
                ))
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              //alignment: Alignment.center,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: _categories[index].imageUrl,
                      categoryName: _categories[index].categoryName,
                    );
                  }),
            ),
          )
        ],
      ),
    ));
  }
}
