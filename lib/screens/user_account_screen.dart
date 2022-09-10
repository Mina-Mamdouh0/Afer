
import 'dart:io';

import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
        builder:(context,state){
      AppCubit cubit=AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: ColorsManger.appbarColor,
          title: Text(LocaleKeys.editInformation.tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width*0.06
              )),
        ),
   body: SingleChildScrollView(
     child: Form(
       key: cubit.userFormKey,
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
         child: Column(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             SizedBox(
               height: size.height*0.05,
             ),
             Align(
               alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width:size.width*0.3,
                      height: size.width*0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: cubit.fileUpdate==null?
                      Image.network('https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?s=612x612',
                        fit: BoxFit.fill,):
                      Image.file(File(cubit.fileUpdate!.path),
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
                                          cubit.updateImage(_picked);
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
                                          cubit.updateImage(_picked);
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
                        child: Icon(cubit.fileUpdate==null?Icons.camera_alt:Icons.edit,
                          color: Colors.white,
                          size: 20,),

                      ),
                    )
                  ],
                ),
             ),

             SizedBox(
               height: size.height*0.02,
             ),
             Row(
               children: [
                 Expanded(
                   child: TheTextFiled(
                   hintText:LocaleKeys.firstNameHint.tr() ,
                     controller:cubit.usernameController ,
                     keyboardType: TextInputType.text,
                     prefix: Icons.person,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return "Please enter a name";
                       }
                       return null;
                     })
                 ),
                 SizedBox(
                   width: 10,
                 ),
                 Expanded(
                   child:TheTextFiled(
                     hintText:LocaleKeys.secondNameHint.tr() ,
                     controller:cubit.username2Controller ,
                     keyboardType: TextInputType.text,
                     prefix: Icons.person,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return "Please enter a name";
                       }
                       return null;
                     }),
                   )
               ],
             ),
             SizedBox(
               height: 20,
             ),
             TheTextFiled(
                 hintText:LocaleKeys.password.tr() ,
                 controller:cubit.userPasswordController ,
                 keyboardType: TextInputType.text,
                 prefix: Icons.password,
                 validator: (value) {
                   if (value!.isEmpty) {
                     return "Please enter a password";
                   }
                   return null;
                 }),
             SizedBox(
               height: 20,
             ),

             TheTextFiled(
                 hintText:LocaleKeys.confirmPassword.tr() ,
                 controller:cubit.userConfirmPasswordController ,
                 keyboardType: TextInputType.text,
                 prefix: Icons.password,
                 validator: (value) {
                   if (value!.isEmpty) {
                     return "Please enter a password";
                   }
                   return null;
                 }),
             SizedBox(
               height: 20,
             ),

             TheTextFiled(
                 hintText:LocaleKeys.WhatsAppHint.tr() ,
                 controller:cubit.userPhoneNumberController ,
                 keyboardType: TextInputType.number,
                 prefix: Icons.phone,
                 validator: (value) {
                   if (value!.isEmpty) {
                     return "Please enter a Phone";
                   }
                   return null;
                 }),
             SizedBox(
               height: 20,
             ),


             MainButton(text: LocaleKeys.update,
                 fct: () {
                   if(cubit.userFormKey.currentState!.validate()) {
                     cubit.updateProfile();
                     Navigator.of(context).pop();
                   }
                 }
             ),

           ],
         ),
       ),
     ),
   )
      );}
    );
  }
}
