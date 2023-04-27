import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/main_page.dart';
import 'package:mobile_app/widgets/login_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  //TODO perform here all necessary logic for moving through widgets basing on auth
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const LoggedInView();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong, try again"),
          );
        } else {
          return const LoginWidget();
        }
      },
    );
    ;
  }
}
