import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget child;
  const CustomAppBar(
      {super.key,
      required this.child,
      this.height = kToolbarHeight,
      required IconButton leading, required Color backgroundColor, required int toolbarHeight});
  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.4,
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 176, 175, 175),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          )),
      child: child,
    );
  }
}
