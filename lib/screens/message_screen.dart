
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../translations/locale_keys.g.dart';

class MessageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.serviceNot.tr(),

        style: const TextStyle(
          fontSize: 22,
          fontFamily: 'Stoor',
          fontWeight: FontWeight.normal,
        ),
        textAlign:  TextAlign.center,
      ),
    );
  }
}
