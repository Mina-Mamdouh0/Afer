
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  double opacity = 1;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.5;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder:(context,state){
        var cuibt=AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: AnimatedScale(
              scale: opacity,
              curve: Curves.easeInBack,
              duration: const Duration(seconds: 2),
              onEnd: () {
                if (sherdprefrence.getdate(key: "token") != null) {
                  cuibt.getInfo(sherdprefrence.getdate(key: "token"));
                  navigator(
                      context: context, page: HomeLayout(), returnPage: false);
                }
                else {
                  navigator(
                      context: context, page: SignScreen(), returnPage: false);
                }
              },
              child: Center(
                  child: Image.asset(
                    PhotoManger.aferLogo,
                    height: 600,
                    width: 600,
                  )
              ),
            ),
          ),

        );
      },

    );
  }
}
