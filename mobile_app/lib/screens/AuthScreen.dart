import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/login_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  //TODO perform here all necessary logic for moving through widgets basing on auth
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginWidget());
  }
}
