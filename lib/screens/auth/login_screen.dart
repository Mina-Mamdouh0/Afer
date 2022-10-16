import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/auth/signup_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';
import 'forget_password.dart';

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

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SingleChildScrollView(
            child: Form(
              key: cubit.signInFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    TheTextFiled(
                      controller: cubit.emailSignInController,
                      hintText: '*****@gmail.com',
                      validator: (value) {
                        if (value!.isEmpty && value.contains("@")) {
                          return LocaleKeys.emailHint.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      prefix: Icons.email,
                      textInputAction: TextInputAction.next,
                      labelText: LocaleKeys.emailHint.tr(),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TheTextFiled(
                      controller: cubit.passwordSignInController,
                      hintText: '**********',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.password.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      prefix: Icons.password,
                      textInputAction: TextInputAction.done,
                      labelText: LocaleKeys.password.tr(),
                      suffixIcon: IconButton(
                        icon: cubit.isObscureSignIn
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () => cubit.changeObscureSignIn(),
                      ),
                      onFieldSubmitted: (value) {
                        if (cubit.signInFormKey.currentState!.validate()) {
                          cubit.signIn(context);
                        }
                      },
                      obscureText: cubit.isObscureSignIn,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CheckboxListTile(
                        value: cubit.rememberMe,
                        onChanged: (value) => cubit.toggleRememberMe(value),
                        title: Text(LocaleKeys.rememberMe.tr())),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Align(
                        alignment: context.locale == const Locale('ar')
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            navigator(
                                context: context,
                                page: const ForgetPassword(),
                                returnPage: true);
                          },
                          child: Text(
                            LocaleKeys.forgetPassword.tr(),
                            style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    MainButton(
                      text: LocaleKeys.signIn.tr(),
                      fct: () {
                        if (cubit.signInFormKey.currentState!.validate()) {
                          cubit.signIn(context);
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
