
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../const/photo_manger.dart';
import '../translations/locale_keys.g.dart';

class MessageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.serviceNot.tr(),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign:  TextAlign.center,
        ),
        SizedBox(height: 15,),
        Text(
          LocaleKeys.serviceSoon.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15,),
        Image(image: AssetImage(PhotoManger.sad),height: 100,width: 100,color: Colors.black),
      ],
    );
  }
}
