import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';
import '../../widget/widget.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(alignment: AlignmentDirectional.topStart,child: IconButton(icon: const Icon(Icons.arrow_back),onPressed: ()=>Navigator.pop(context))),
                    if (cubit.isSend)
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .15),
                        child: Lottie.asset(
                            alignment: Alignment.center,
                            PhotoManger.sendEmail,
                            width: size.width,
                            height: size.height * .40),
                      ),
                    if (!cubit.isSend)
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .15),
                        child: Lottie.asset(
                            alignment: Alignment.center,
                            PhotoManger.forgetPassword,
                            width: size.width,
                            height: size.height * .40),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TheTextFiled(
                      controller: cubit.emailSignInController,
                      hintText: 'Afer@gmail.com',
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
                    const SizedBox(
                      height: 20,
                    ),
                    MainButton(
                      text: LocaleKeys.sendForgetPassword.tr(),
                      fct: () => cubit.forgetPassword(
                          cubit.emailSignInController.text, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
