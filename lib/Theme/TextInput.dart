import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Widget? icon1]) {
    return InputDecoration(
      hintText: hintText,
      labelText: lableText,
      hintStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.normal),
      suffix: icon1,
      fillColor: Colors.white,
      filled: true,
      // contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
      ),
      // Specify border color and width
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(5, 5)),
      backgroundColor: MaterialStateProperty.all(
        Color.fromRGBO(178, 142, 22, 1),
      ),
      shadowColor: MaterialStateProperty.all(
        Color.fromRGBO(178, 142, 22, 1),
      ),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class LoginFormStyle {}
