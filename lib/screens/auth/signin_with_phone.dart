import 'package:afer/Extintion/extinition.dart';
import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';
import '../../widget/widget.dart';

class SignInPhone extends StatefulWidget {
  const SignInPhone({Key? key}) : super(key: key);

  @override
  State<SignInPhone> createState() => _SignInState();
}

class _SignInState extends State<SignInPhone> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:  Text(LocaleKeys.signInWithPhone.tr()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
               Text(
              LocaleKeys.enterPhone.tr(),
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              Image(
                image: const AssetImage(PhotoManger.phoneSignIn),
                height: size.height * 0.4,
              ),
              TheTextFiled(
                hintText:LocaleKeys.enterPhone.tr() ,
                prefix: Icons.phone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                controller: AppCubit.get(context).phoneNumberController,
                maxLength: 11,
                validator: (value) {
                  if (value!.isPhoneNumber) {
                    return "Enter Valid Phone Number";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    navigator(
                        context: context,
                        page: PhoneAuth(
                            phone: AppCubit.get(context)
                                .phoneNumberController
                                .text),
                        returnPage: true);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MainButton(
                text: LocaleKeys.verify.tr(),
                fct: () {
                  if (formKey.currentState!.validate()) {
                    navigator(
                        context: context,
                        page: PhoneAuth(
                            phone: AppCubit.get(context)
                                .phoneNumberController
                                .text),
                        returnPage: true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneAuth extends StatefulWidget {
  final String phone;

  const PhoneAuth({Key? key, required this.phone}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  var otp = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    AppCubit.get(context)
        .verifyPhoneNumber(context: context, phone: widget.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  '${LocaleKeys.you.tr()} ${LocaleKeys.verify.tr()} +2${widget.phone} ',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                   LocaleKeys.enterPin.tr(),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Image(
                  image: const AssetImage(PhotoManger.phoneSignIn),
                  height: size.height * 0.4,
                ),
                PinCodeTextField(

                  autoDisposeControllers: true,
                  useHapticFeedback: true,
                  keyboardType: TextInputType.number,
                  obscuringCharacter: '*',
                  controller: otp,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: ColorsManger.appbarColor,
                    inactiveFillColor: ColorsManger.appbarColor,
                    activeColor: Colors.grey,
                    inactiveColor: Colors.grey,
                  ),
                  length: 6,
                  autoDismissKeyboard: true,
                  enablePinAutofill: true,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  autoFocus: true,
                  autoUnfocus: true,
                  hintCharacter: "*",
                  onChanged: (String value) {},
                  appContext: context,
                  enableActiveFill: true,
                  onCompleted: (value) async => context
                      .read<AppCubit>()
                      .signInWithPhone(context, otp.text,widget.phone,),
                  useExternalAutoFillGroup: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MainButton(
                    text: LocaleKeys.verify.tr(),
                    fct: () async => context
                        .read<AppCubit>()
                        .signInWithPhone(context, otp.text,widget.phone,)),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: RichText(

                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Code didnt send ?',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900)),
                        TextSpan(
                          style: const TextStyle(color: Colors.blue,fontSize: 20),
                            recognizer:  TapGestureRecognizer()
                              ..onTap = () {
                               context.read<AppCubit>().verifyPhoneNumber(context: context,phone: widget.phone);
                              },
                            text: 'Resend'
                        ),
                      ]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
