
import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},builder:(context,state){
      Size size=MediaQuery.of(context).size;
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
     child: Container(
         padding: EdgeInsets.symmetric(horizontal: 10),
         height: size.height*0.8,

         child: Form(
           key: cubit.userFormKey,
           child: SingleChildScrollView(
             child: Column(
               mainAxisSize: MainAxisSize.max,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 30,
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
                 /*myTextForm(
                   hint: "الرقم السري",
                   controller: cubit.,
                   prefix: const Icon(Icons.),
                   obscureText: cubit.isObscureEditInfo,
                   validator: (value) {
                     if (value.isEmpty) {
                       return "";
                     }
                     return null;
                   },
                 ),*/

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


                 MainButton(text: 'تحديث',
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
         )

     ),
   )
      );}
    );
  }
}
