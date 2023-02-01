import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/auth/signin_with_phone.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../const/colors_manger.dart';
import '../../translations/locale_keys.g.dart';
import 'forget_password.dart';

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
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width, 50),
                          backgroundColor:
                              ColorsManger.appbarColor.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () => navigator(
                            context: context,
                            page: const SignInPhone(),
                            returnPage: true),
                        icon: const Icon(
                          IconlyBold.call,
                          color: Colors.white,
                        ),
                        label: Text(
                          LocaleKeys.signInWithPhone.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width, 50),
                          backgroundColor:
                              ColorsManger.appbarColor.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () => cubit.signInWithGoogle(context),
                        icon: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png",
                          width: 30,
                          height: 30,
                        ),
                        label: Text(
                          LocaleKeys.signInGoogle.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: size.height * 0.02,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
