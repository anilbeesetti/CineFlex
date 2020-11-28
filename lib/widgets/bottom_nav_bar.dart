import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
    this.selectedIndex = 0,
    this.backgroundColor,
    @required this.tabs,
    this.height,
  }) : super(key: key);
  final int selectedIndex;
  final Color backgroundColor;
  final List<Widget> tabs;
  final double height;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.backgroundColor, boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.black38, offset: Offset(0, -1))
      ]),
      height: widget.height ?? 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.tabs,
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  const NavButton({
    Key key,
    @required this.isSelected,
    @required this.icon,
    @required this.label,
    this.selectedTabBackgroundColor,
    this.iconColor,
    this.selectedIconColor,
    this.selectedTextColor,
    @required this.onPress,
  }) : super(key: key);

  final bool isSelected;
  final IconData icon;
  final Color iconColor;
  final Color selectedIconColor;
  final String label;
  final Color selectedTabBackgroundColor;
  final Color selectedTextColor;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 15, vertical: 8)
            : EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? selectedTabBackgroundColor : null,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? selectedIconColor : iconColor,
            ),
            isSelected
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          label,
                          style: TextStyle(
                              color: isSelected ? selectedTextColor : null),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
