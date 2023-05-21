import 'dart:developer';

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/main_views/add_new_item.dart';
import 'package:mobile_app/screens/main_views/inventory_list_view.dart';
import 'package:mobile_app/screens/main_views/items_list_view.dart';
import 'package:provider/provider.dart';

import '../utils/google_sign_in.dart';
import '../utils/search_model.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({Key? key}) : super(key: key);

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}


class _LoggedInViewState extends State<LoggedInView> {
  int _currentIndex = 0;

  SearchModel searchModel = SearchModel();

  final List<Widget> _screens = [
    const InventoryList(),
    const ItemsListView(),
    const BarCodeScreen(),
  ];
  final List<String> _appBarTitles = [
    "Inventory",
    "Items",
    "Scanner",
  ];

  final _navbarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: "Items"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.center_focus_strong_outlined,
        ),
        label: "Scan"), // const BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout")
  ];

  @override
  Widget build(BuildContext context) {
    var logoutButton = IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        final provider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.logout();
      },
    );

    var bar = _currentIndex == 0 || _currentIndex == 1
        ? EasySearchBar(
          title: Text(_appBarTitles[_currentIndex]),
          actions: [logoutButton],
          onSearch: (query) => searchModel.setSearchQueryTo(query),
          putActionsOnRight: true,
          foregroundColor: Colors.white,
          isFloating: false,
        ) : AppBar(
          title: Text(_appBarTitles[_currentIndex]),
          actions: [logoutButton],
          centerTitle: false,
        );

    return Scaffold(
      appBar: bar as PreferredSizeWidget?,
      body: ChangeNotifierProvider(
        create: (context) => searchModel,
        child: IndexedStack(
          key: const Key("stack"),
          index: _currentIndex,
          alignment: AlignmentDirectional.center,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          key: const Key("navigation-bar"),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueAccent,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: false,
          onTap: (index) {
            // if (index == 3) {
            //   final provider =
            //       Provider.of<GoogleSignInProvider>(context, listen: false);
            //   provider.logout();
            // }
            setState(() {
              _currentIndex = index;
            });
          },
          items: _navbarItems),
    );
  }
}
