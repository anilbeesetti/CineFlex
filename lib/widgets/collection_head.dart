import 'package:cineflex/constansts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionHead extends StatelessWidget {
  const CollectionHead({
    Key key,
    this.padding,
    @required this.title,
    this.onPress,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          TextButton(
            child: Row(
              children: [
                Text(
                  'See all',
                  style: TextStyle(
                    color: kAccentColor,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: kAccentColor,
                ),
              ],
            ),
            onPressed: onPress,
          )
        ],
      ),
    );
  }
}
