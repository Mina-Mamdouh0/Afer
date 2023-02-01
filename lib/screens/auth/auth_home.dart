import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/auth/signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is ChangeRegisterScreen) {}
    }, builder: (context, state) {
      var cubit = BlocProvider.of<AppCubit>(context);
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: size.width * 0.125,
                    backgroundImage: const AssetImage(PhotoManger.logo),
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.welcome.tr(),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.08,
                      ),
                    ),
                  )
                ],
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFEEEEEE),
            elevation: 0,
            toolbarHeight: size.height * 0.2,
            bottom: TabBar(
              onTap: (value) {
                cubit.changeRegister(value);
              },
              indicatorColor: Colors.blue[700],
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Text(
                  LocaleKeys.signIn.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  LocaleKeys.signUp.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            LoginScreen(),
            SignupScreen(),
          ]),
        ),
      );
    });
  }
}

