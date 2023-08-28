// ignore_for_file: no_logic_in_create_state

import "package:flutter/material.dart";
import "package:campus_dots/screens/wrapper.dart";

class Splash extends StatefulWidget {
  const Splash({super.key});

  BuildContext? get context => null;

  void initState() {
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context!, MaterialPageRoute(builder: (context) => const Wrapper()));
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    //todo: implement createState
    throw UnimplementedError();
  }
}
