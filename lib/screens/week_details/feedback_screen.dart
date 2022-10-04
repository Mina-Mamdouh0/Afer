
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cuibt/app_cuibt.dart';



class FeedBackScreen extends StatelessWidget {

  FeedBackScreen({Key? key}) : super(key: key);
  final TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConditionalBuilder(
          condition:context.read<AppCubit>().studentNotes.isEmpty,
          fallback: (context)=>Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(
          context.read<AppCubit>().studentNotes,
          style: const TextStyle(
            fontSize: 25,
            fontFamily: 'Stoor',
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        )
            ],
          ),
          builder: (context) {
            return Column(
              children: [

                TheTextFiled(
                  controller: controller,
                  hintText: LocaleKeys.feedback.tr(),
                  keyboardType: TextInputType.text,
                  prefix: 1,
                  maxLine: 12,
   ),
                const SizedBox(height: 10,),

                MainButton(
                  fct: (){
                   BlocProvider.of<AppCubit>(context).uploadNotes(notes: controller.text, );
                   controller.clear();
                  },
                  text:LocaleKeys.confirm.tr() ,
                ),
              ],
            );
          }
        ),
      );
  }
}
