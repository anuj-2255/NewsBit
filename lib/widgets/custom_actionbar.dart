import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shortnews/helper/constants.dart';

class CustomActionBar extends StatelessWidget {
  final String text;
  final String leftButtonName;
  final String rightButtonName;
  final bool hasDarkMode;
  final bool hasLeftButton;
  final bool isDark;
  final bool hasRightButton;
  final Function leftButtonTap;
  final Function rightButtonTap;

  const CustomActionBar(
      {Key key,
      this.text,
      this.hasDarkMode,
      this.hasLeftButton,
      this.hasRightButton,
      this.leftButtonName,
      this.rightButtonName,
      this.leftButtonTap,
      this.rightButtonTap,
      this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = hasDarkMode ?? false;
    bool _hasLeftButton = hasLeftButton ?? true;
    bool _hasRightButton = hasRightButton ?? true;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 80,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 31, 0, 0),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: Constants.actionBarTitle,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _hasLeftButton
                      ? Container(
                          child: (Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.lightBlue,
                                size: 22,
                              ),
                              if (leftButtonName != null)
                                Text(
                                  leftButtonName,
                                  style: Constants.actionBarButtons,
                                ),
                            ],
                          )),
                        )
                      : Spacer(),
                  if (_hasRightButton)
                    Container(
                      child: (Row(
                        children: [
                          if (rightButtonName != null)
                            Text(
                              rightButtonName,
                              style: Constants.actionBarButtons,
                            ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.lightBlue,
                            size: 22,
                          ),
                        ],
                      )),
                    ),
                  if (_isDarkMode)
                    GestureDetector(
                      onTap: rightButtonTap,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.nightlight_round,
                          color: Colors.lightBlue,
                          size: 22,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
