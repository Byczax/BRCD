import "package:flutter/material.dart";

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);
  final double _padding = 50;
  final double _buttonPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _padding),
            child: Text(
              "Witaj w aplikacji BRCD",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(_buttonPadding)),
            child: const Text("Autoryzuj się googlem"),
          )
        ],
      ),
    );
  }
}
