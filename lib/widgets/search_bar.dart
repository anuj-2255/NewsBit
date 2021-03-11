import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSubmit;

  const SearchBar({Key key, this.onSubmit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmit,
      autofocus: true,
      decoration: InputDecoration(border: InputBorder.none),
      style: TextStyle(color: Colors.black87),
    );
  }
}
