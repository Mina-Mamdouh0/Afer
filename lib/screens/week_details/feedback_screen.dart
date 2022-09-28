
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({Key? key}) : super(key: key);
  final TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TheTextFiled(
              controller: controller,
              hintText: LocaleKeys.feedback.tr(),
              prefix: Icons.feedback,
              keyboardType: TextInputType.text,
              maxLine: 12,
   ),
            const SizedBox(height: 10,),

            MainButton(
              fct: (){
               // BlocProvider.of<AppCubit>(context).showImageVideo();
              },
              text:LocaleKeys.confirm.tr() ,
            ),
          ],
        ),
      );
  }
}
