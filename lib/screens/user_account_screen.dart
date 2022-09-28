
import 'dart:io';

import 'package:afer/Extintion/extinition.dart';
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: cubit.file==null?
                      Image.network(cubit.user.profileUrl??"https://media.istockphoto.com/vectors/user-avatar-profile-icon-black-vector-illustration-vector-id1209654046?k=20&m=1209654046&s=612x612&w=0&h=Atw7VdjWG8KgyST8AXXJdmBkzn0lvgqyWod9vTb2XoE=",
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
                                          cubit.updateImage(picked);
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
                                          cubit.updateImage(picked);
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
                 const SizedBox(
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
             const SizedBox(
               height: 20,
             ),
             TheTextFiled(
                 hintText:LocaleKeys.password.tr() ,
                 controller:cubit.userPasswordController ,
                 keyboardType: TextInputType.text,
                 prefix: Icons.password,
               validator: (value) {
                 if (value!.isPassword) {
                   return 'at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number';
                 }
                 return null;
               },
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
             const SizedBox(
               height: 20,
             ),

             TheTextFiled(
                 hintText:LocaleKeys.confirmPassword.tr() ,
                 controller:cubit.userConfirmPasswordController ,
                 keyboardType: TextInputType.text,
                 prefix: Icons.password,
               validator: (value) {
                 if (value != cubit.userPasswordController.text) {
                   return 'Password not match';
                 }
                 return null;
               },
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
             const SizedBox(
               height: 20,
             ),

             TheTextFiled(
                 hintText:LocaleKeys.WhatsAppHint.tr() ,
                 controller:cubit.userPhoneNumberController ,
                 keyboardType: TextInputType.number,
                 prefix: Icons.phone,
               validator: (value) {
                 if (value!.isPhoneNumber) {
                   return "not valid must be like this 01*********";
                 }
                 return null;
               },
               maxLength: 11,
               textInputAction: TextInputAction.next,
               labelText: LocaleKeys.WhatsAppHint.tr(),
                 ),
             const SizedBox(
               height: 20,
             ),
             MainButton(text: LocaleKeys.editInformation.tr(),
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
