import 'dart:io';

import 'package:afer/Extintion/extinition.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../translations/locale_keys.g.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: Form(
            key: cubit.SignUpFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size.height*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TheTextFiled(
                          controller:cubit.nameController ,
                          hintText:  LocaleKeys.firstNameHint.tr(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your first Name";
                  }
                  return null;
                },
                          keyboardType:TextInputType.text ,
                          prefix: Icons.perm_identity_rounded,
                          textInputAction: TextInputAction.next,
                          labelText:  LocaleKeys.firstNameHint.tr(),
                        )),
                      SizedBox(width: 5,),

                      Expanded(
                          child: TheTextFiled(
                            controller:cubit.lastNameController ,
                            hintText:  LocaleKeys.secondNameHint.tr(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your second Name";
                              }
                              return null;
                            },
                            keyboardType:TextInputType.text ,
                            prefix: Icons.perm_identity_rounded,
                            textInputAction: TextInputAction.next,
                            labelText:  LocaleKeys.secondNameHint.tr(),
                          ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height*0.02,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(

                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
                        hintStyle:const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.event),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black,),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.red,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black,),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black,),)
                    ),

                    items: [
                      DropdownMenuItem(
                        value: "First year",
                        child: Text(LocaleKeys.firstYear.tr()),
                      ),
                      DropdownMenuItem(
                        value: "Second year",
                        child: Text(LocaleKeys.secondyear.tr()),
                      ),
                      DropdownMenuItem(
                        value: "Third Year",
                        child: Text(LocaleKeys.thirdYear.tr()),
                      ),
                      DropdownMenuItem(
                        value: "Fourth Year",
                        child: Text(LocaleKeys.fourthYear.tr()),
                      ),
                    ],
                    onChanged: (value) => cubit.changeAcadimicYear(value),
                    value: cubit.academicYear,
                  ),
                  SizedBox(height: size.height*0.02,),
                  TheTextFiled(
                    controller:cubit.emailController ,
                    hintText: '*****@gmail.com',
                    validator:  (value){
                      if(value!.isEmpty&&value.contains("@")){
                        return 'your email is not valid must be like this *****@****.com';
                      }
                      return null;
                    },
                    keyboardType:TextInputType.emailAddress ,
                    prefix: Icons.email,
                    textInputAction: TextInputAction.next,
                    labelText: LocaleKeys.emailHint.tr(),
                  ),
                  SizedBox(height: size.height*0.02,),
                  TheTextFiled(
                    controller:cubit.phoneNumberController ,
                    hintText: '01*********',
                    validator: (value) {
                      if (value!.isPhoneNumber) {
                        return "not valid must be like this 01*********";
                      }
                      return null;
                    },
                    keyboardType:TextInputType.phone ,
                    prefix: Icons.phone,
                    textInputAction: TextInputAction.next,
                    labelText: LocaleKeys.WhatsAppHint.tr(),
                  ),
                  SizedBox(height: size.height*0.02,),
                  TheTextFiled(
                    controller:cubit.passwordController ,
                    hintText: '**********',
                    validator: (value) {
                      if (value!.isPassword) {
                        return 'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number';
                      }
                      return null;
                    },
                    keyboardType:TextInputType.visiblePassword ,
                    prefix: Icons.password,
                    textInputAction: TextInputAction.next,
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: IconButton(
                      icon: cubit.isObscureSignup
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () => cubit.changeObscureSignUp(),
                    ),
                    obscureText: cubit.isObscureSignup,
                    helperText:
                    'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number',

                  ),

                  SizedBox(height: size.height*0.02,),
                  TheTextFiled(
                    controller:cubit.confirmPasswordController ,
                    hintText: '**********',
                    validator: (value) {
                      if (value != cubit.passwordController.text) {
                        return 'Password not match';
                      }
                      return null;
                    },
                    keyboardType:TextInputType.visiblePassword ,
                    prefix: Icons.password,
                    textInputAction: TextInputAction.done,
                    labelText:'${LocaleKeys.confirm.tr()} ${LocaleKeys.password.tr()}',
                    suffixIcon: IconButton(
                      icon: cubit.isObscureSignup
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () => cubit.changeObscureSignUp(),
                    ),
    onFieldSubmitted: (_){
    if (cubit.SignUpFormKey.currentState!.validate()) {
    cubit.signUp(context);
    }},
                    obscureText: cubit.isObscureSignup,
                    helperText:
                    'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number',

                  ),
                  SizedBox(height: size.height*0.02,),
                  MainButton(text: LocaleKeys.createAccount.tr(), fct: () {
                    if(cubit.SignUpFormKey.currentState!.validate()) {
                      cubit.signIn(context);
                    }
                  },),
                  SizedBox(height: size.height*0.02,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
