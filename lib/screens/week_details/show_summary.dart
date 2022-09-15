
import 'package:afer/const/photo_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../translations/locale_keys.g.dart';


class ShowSummery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.serviceNot.tr(),
          style:  const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign:  TextAlign.center,
        ),
        const SizedBox(height: 15,),
        Text(
          LocaleKeys.serviceSoon.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15,),
        const Image(image: AssetImage(PhotoManger.sad),height: 100,width: 100,color: Colors.black),
      ],
    );
  }
}
