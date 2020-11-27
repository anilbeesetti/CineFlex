import 'package:flutter/material.dart';

import '../constansts.dart';

class InformationText extends StatelessWidget {
  const InformationText({
    Key key,
    @required this.text,
    @required this.subText,
  }) : super(key: key);
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.blueGrey[500],
          ),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: kAccentColor,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: subText,
            )
          ],
        ),
      ),
    );
  }
}
