import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../const/photo_manger.dart';


class DisConnected extends StatefulWidget {
  const DisConnected({Key? key}) : super(key: key);

  @override
  State<DisConnected> createState() => _DisConnectedState();
}

class _DisConnectedState extends State<DisConnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
Lottie.asset(PhotoManger.lostConnection),

        ],
      ),
    );
  }
}
