import 'package:afer/Extintion/extinition.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../translations/locale_keys.g.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: cuibt.SignUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cuibt.nameController,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.firstNameHint.tr(),
                          labelText: LocaleKeys.firstNameHint.tr(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your first Name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: cuibt.lastNameController,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.secondNameHint.tr(),
                          labelText: LocaleKeys.secondNameHint.tr(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your second Name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                DropdownButtonFormField(
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
                  onChanged: (value) => cuibt.changeAcadimicYear(value),
                  value: cuibt.academicYear,
                ),
                TextFormField(
                  controller: cuibt.emailController,
                  decoration: InputDecoration(
                    hintText: '*****@gmail.com',
                    labelText: LocaleKeys.emailHint.tr(),
                  ),
                  validator: (value) {
                    if (value!.isEmail) {
                      return "your email is not valid must be like this *****@****.com";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: cuibt.phoneNumberController,
                  decoration: InputDecoration(
                    hintText: '01*********',
                    labelText: LocaleKeys.WhatsAppHint.tr(),
                  ),
                  validator: (value) {
                    if (value!.isPhoneNumber) {
                      return "not valid must be like this 01*********";
                    }
                    return null;
                  },
                  maxLength: 11,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: cuibt.passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: cuibt.isObscureSignup
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () => cuibt.changeObscureSignUp(),
                    ),
                    hintText: '**********',
                    labelText: LocaleKeys.password.tr(),
                    helperText:
                        'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number',
                  ),
                  obscureText: cuibt.isObscureSignup,
                  validator: (value) {
                    if (value!.isPassword) {
                      return 'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number';
                    }
                    return null;
                  },
                  toolbarOptions: ToolbarOptions(
                    copy: false,
                    cut: false,
                    paste: false,
                    selectAll: false,
                  ),
                ),
                TextFormField(
                  controller: cuibt.confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: '**********',
                    labelText:
                        '${LocaleKeys.confirm.tr()} ${LocaleKeys.password.tr()}',
                  ),
                  validator: (value) {
                    if (value != cuibt.passwordController.text) {
                      return 'Password not match';
                    }
                    return null;
                  },
                  obscureText: cuibt.isObscureSignup,
                  onFieldSubmitted: (_){
                    if (cuibt.SignUpFormKey.currentState!.validate()) {
                      cuibt.signUp(context);
                    }

                  },
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(18),
                  onPressed: () {
                    if (cuibt.SignUpFormKey.currentState!.validate()) {
                      cuibt.signUp(context);
                    }
                  },
                  color: Colors.blue[700],
                  minWidth: double.infinity,
                  child: Text(
                    LocaleKeys.createAccount.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
