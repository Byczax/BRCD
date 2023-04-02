import 'package:flutter/material.dart';
import 'package:mobile_app/screens/AuthScreen.dart';
import 'package:mobile_app/screens/main_views/add_new_item.dart';
import 'package:mobile_app/screens/main_page.dart';

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
        home: LoggedInView()
        //const AuthScreen(),
        );
  }
}
