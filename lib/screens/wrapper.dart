// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import "package:flutter_application_1/models/current_user.dart";
import "package:flutter_application_1/screens/authenticate/authenticate.dart";
import "package:flutter_application_1/screens/home/home.dart";
import "package:provider/provider.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    //return either home or authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
