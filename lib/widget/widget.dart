import 'package:flutter/material.dart';

import '../const/colors_manger.dart';




 navigator({page, context, returnPage = false}) {
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> page,),(Route route)=>returnPage,);
}
class TheTextFiled extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final IconData ? prefix;
  final TextInputType keyboardType;
  final String? labelText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Function(String)? onFieldSubmitted;
  final bool? obscureText;
final int? maxLength;
final int? maxLine;

  const TheTextFiled({Key? key, this.validator, required this.controller, required this.hintText,  this.prefix, required this.keyboardType, this.labelText, this.textInputAction, this.suffixIcon, this.onFieldSubmitted, this.obscureText, this.helperText,this.maxLength, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
maxLength: maxLength,
      maxLines: maxLine??1,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscureText??false,
      textInputAction: textInputAction??TextInputAction.next,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
          helperText: helperText,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(prefix),
          suffixIcon: suffixIcon,
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
      validator: validator,

    );
  }
}




class MainButton extends StatelessWidget {
  final String text;
      final Function() fct;
  const MainButton({Key? key, required this.text, required this.fct,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      onPressed: fct,
      height: 50,
      minWidth: double.infinity,
      color: ColorsManger.appbarColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(text,
    style: TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold,
    fontSize: MediaQuery.of(context).size.width*0.05),
    ),

    );
  }
}



