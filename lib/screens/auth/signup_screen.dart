
import 'dart:io';

import 'package:afer/Extintion/extinition.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
            key: cubit.signUpFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size.height*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
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
                      const SizedBox(width: 5,),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width:70,
                            height: kBottomNavigationBarHeight,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: cubit.file==null?
                            Image.network('https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?s=612x612',
                              fit: BoxFit.fill,):
                            Image.file(File(cubit.file!.path),
                              fit: BoxFit.fill,),
                          ),
                          GestureDetector(
                            onTap: (){
                              showDialog(context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title:const  Text(
                                        'Please choose an option',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: ()async{
                                              Navigator.pop(context);
                                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                              if(picked !=null){
                                                cubit.takeImage(picked);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.photo,color: Colors.purple,),
                                                  SizedBox(width: 10,),
                                                  Text('Camera',
                                                    style: TextStyle(
                                                        color: Colors.purple,fontSize: 20
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: ()async{
                                              Navigator.pop(context);
                                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                              if(picked !=null){
                                                cubit.takeImage(picked);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.camera,color: Colors.purple,),
                                                  SizedBox(width: 10,),
                                                  Text('Gallery',
                                                    style: TextStyle(
                                                        color: Colors.purple,fontSize: 20
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2,
                                      color: Colors.white),
                                  color: Colors.pink
                              ),
                              child: Icon(cubit.file==null?Icons.camera_alt:Icons.edit,
                                color: Colors.white,
                                size: 20,),

                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height*0.02,),
                  TheTextFiled(
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
                  SizedBox(height: size.height*0.02,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(

                        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
                        hintStyle:const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.event),
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
                        child: Text(LocaleKeys.secondYear.tr()),
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
                    maxLength: 11,
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
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
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
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () => cubit.changeObscureSignUp(),
                    ),
    onFieldSubmitted: (_){
    if (cubit.signUpFormKey.currentState!.validate()) {
    cubit.signUp(context);
    }},
                    obscureText: cubit.isObscureSignup,
                    helperText:
                    'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number',

                  ),
                  SizedBox(height: size.height*0.02,),
                  MainButton(text: LocaleKeys.createAccount.tr(), fct: () {
                    if(cubit.signUpFormKey.currentState!.validate()) {
                      cubit.signUp(context);
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
