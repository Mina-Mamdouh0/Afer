
import 'dart:async';

import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/widget/widget.dart';
import 'package:flutter/material.dart';
import '../const/photo_manger.dart';
import 'auth/login_screen.dart';
import 'package:afer/SheredPreferance/sheredHelper.dart';
import 'home_loyout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var Interstitial;
  @override
  void initState() {

    Timer(
        const Duration(seconds: 2),
            () async {
          if (sherdprefrence.getdate(key: "token") != null) {
            AppCubit.get(context).getInfo(
                sherdprefrence.getdate(key: "token"));
            navigator(
                context: context, page: const HomeLayout(), returnPage: false);
          }
          else {
            navigator(context: context,
                page: const AuthScreen(),
                returnPage: false);
          }
        });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Image.asset(
              PhotoManger.logo,
              height: 500,
              width: 500,
            )
        ),
      ),

    );
  }

}

