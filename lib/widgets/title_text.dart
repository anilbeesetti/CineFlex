import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
    @required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    );
  }
}
