
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../Owner/Communication/communicationPage.dart';
import '../Owner/Home/HomePage.dart';
import '../Owner/Profile/Profile.dart';

class BottomTabBarPageforowner extends StatefulWidget {
  @override
  _BottomTabBarPageforownerState createState() =>
      _BottomTabBarPageforownerState();
}

class _BottomTabBarPageforownerState extends State<BottomTabBarPageforowner> {
  int _currentIndex = 0;

  List<Widget> _contentWidgets = [
    OwenerHomepage(),
    Communication(),
    Communication(),
    Profile()
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Ionicons.location,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.messenger,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 30,
      ),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _contentWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false, // hide selected labels
        showUnselectedLabels: false,
        selectedItemColor: Color.fromRGBO(226, 193, 121, 1),
        unselectedItemColor: Colors.grey,
        items: _bottomNavBarItems,
      ),
    );
  }
}
