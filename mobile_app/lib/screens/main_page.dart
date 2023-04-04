import 'package:flutter/material.dart';
import 'package:mobile_app/screens/main_views/add_new_item.dart';
import 'package:mobile_app/screens/main_views/scanned_objects_list.dart';
import 'package:mobile_app/screens/main_views/settings.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({Key? key}) : super(key: key);

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const InventoryList(),
    const BarCodeScreen(),
    const SettingsWidget()
  ];

  final _navbarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.center_focus_strong_outlined,
        ),
        label: "Scan"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        key: const Key("stack"),
        index: _currentIndex,
        alignment: AlignmentDirectional.center,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          key: const Key("navigation-bar"),
          backgroundColor: Colors.blueAccent,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: _navbarItems),
    );
  }
}
