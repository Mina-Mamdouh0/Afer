import 'dart:io';

import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/auth/signup_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is ChangeRegisterScreen){

        }
      },
      builder: (context,state) {
        var cubit=BlocProvider.of<AppCubit>(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(

              title:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  cubit.indexRegisterScreen==0?
                  CircleAvatar(
                    radius: size.width*0.15,
                    backgroundImage: AssetImage(PhotoManger.aferLogo),
                    backgroundColor: Colors.transparent,
                  ): Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width:size.width*0.3,
                        height: size.width*0.3,
                        decoration: BoxDecoration(
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
                                          XFile? _picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                          if(_picked !=null){
                                            cubit.takeImage(_picked);
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
                                          XFile? _picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                          if(_picked !=null){
                                            cubit.takeImage(_picked);
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
                  ),
                  Text(
                    LocaleKeys.welcome.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*0.08,),
                  )
                ],
              ),
              centerTitle: true,
              backgroundColor: const Color(0xFFEEEEEE),
              elevation: 0,
              toolbarHeight: size.height*0.2,
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
                        fontSize: size.width*0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    LocaleKeys.signUp.tr(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width*0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            ),
            body: TabBarView(
                children: [
                  LoginScreen(),
                  const SignupScreen(),
                ]),
          ),
        );
      }
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state){},
      builder: (context,state) {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: Form(
            key:cubit.SignInFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size.height*0.04,),
                  TheTextFiled(
                    controller:cubit.emailSignInController ,
                    hintText: '*****@gmail.com',
                    validator:  (value){
                      if(value!.isEmpty&&value.contains("@")){
                        return LocaleKeys.emailHint.tr();
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
                    controller:cubit.passwordSignInController ,
                    hintText: '**********',
                    validator: (value){
                      if(value!.isEmpty){
                        return LocaleKeys.password.tr();
                      }
                      return null;
                    },
                    keyboardType:TextInputType.visiblePassword ,
                    prefix: Icons.password,
                    textInputAction: TextInputAction.done,
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: IconButton(
                      icon:cubit.isObscureSignIn? Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: ()=> cubit.changeObscureSignIn(),
                    ),
                    onFieldSubmitted: (value){
                      if(cubit.SignInFormKey.currentState!.validate()) {
                        cubit.signIn(context);
                      }
                    },
                    obscureText: cubit.isObscureSignIn,
                  ),
                  SizedBox(height: size.height*0.01,),
                  CheckboxListTile(
                      value: cubit.rememberMe,
                      onChanged: (value) =>
                          cubit.toggleRememberMe(value),
                      title: Text(LocaleKeys.rememberMe.tr())),
                  SizedBox(height: size.height*0.01,),
                  Align(
                      alignment:context.locale==Locale('ar')? Alignment.centerLeft:Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.forgetPassword.tr(),
                          style:  TextStyle(
                              fontSize: size.width*0.04,
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                          ),

                        ) ,
                      )
                  ),
                  SizedBox(height: size.height*0.02,),
                  MainButton(text: LocaleKeys.signIn.tr(), fct: () {
                    if(cubit.SignInFormKey.currentState!.validate()) {
                      cubit.signIn(context);
                    }
                  },),
                  SizedBox(height: size.height*0.02,),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

