

import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';

class LectureScreen extends StatelessWidget {
  LectureScreen({Key? key}) : super(key: key);
  List<String> weekDetails = [LocaleKeys.lecture.tr(),LocaleKeys.video.tr(), LocaleKeys.Summary.tr(), LocaleKeys.questions.tr()];

  List<Image> mainIcons = const [
    Image(
      image: AssetImage(PhotoManger.pdf),
      color: Colors.blue,
      width: 30,
    ),
    Image(
      image: AssetImage(PhotoManger.camera),
      color: Colors.blue,
      width: 30,
    ),
    Image(
      image: AssetImage(PhotoManger.light),
      color: Colors.blue,
      width: 30,
    ),
    Image(
      image: AssetImage(PhotoManger.exam),
      color: Colors.blue,
      width: 30,
    ),
  ];
  late AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: ColorsManger.appbarColor,
              title: Text(LocaleKeys.lecture.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*0.06
                  )),
            ),
            body: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(4, (index) => tabBuilder(index,cubit,context))),
                  Expanded(
                    child: cubit.lectureScreen[cubit.weekTemplateCurrentIndex],
                  )
                ])),
          );
        });
  }

  Widget tabBuilder(int index,AppCubit cuibt,context) {
    return InkWell(
      onTap: () {
          cubit.weekTemplateChangeIndex(index);

      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              (cubit.weekTemplateCurrentIndex == index)
                  ? CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 30,
                      child: mainIcons[index],
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 30,
                      child: mainIcons[index],
                    ),
              const SizedBox(
                height: 5,
              ),
              Text(
                weekDetails[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          ConditionalBuilder(
            condition:cuibt.locked[index],
            fallback:(context) {
              return const Center(
                  child: Icon(Icons.lock_open_outlined,size: 20,)
              );
            } ,
            builder: (context) {
              return const Center(
                child: Icon(Icons.lock_outline_rounded,size: 20,)
              );
            }
          )
        ],
      ),
    );
  }
}
