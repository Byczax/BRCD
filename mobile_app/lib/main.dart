import 'package:flutter/material.dart';
import 'package:mobile_app/screens/auth_screen.dart';
import 'package:mobile_app/screens/main_views/add_new_item.dart';
import 'package:mobile_app/screens/main_page.dart';
import 'package:mobile_app/screens/main_views/new_item_screen.dart';
import 'package:mobile_app/widgets/item_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRCD scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const AuthScreen(),
        "/logged_in": (context) => const LoggedInView(),
        "/logged_in/form": (context) => const NewItemScreen()
      },
    );
  }
}
