import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';

class LectureScreen extends StatefulWidget {
  final String subjectName;
  final String academicYear;
  final String lectureName;

  LectureScreen({Key? key, required this.subjectName, required this.academicYear, required this.lectureName}) : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState(lectureName: lectureName, subjectName: subjectName, academicYear: academicYear);
}

class _LectureScreenState extends State<LectureScreen> {
  _LectureScreenState({required this.subjectName, required this.academicYear,required this.lectureName});
  final String subjectName;
  final String academicYear;
  final String lectureName;
  List<String> weekDetails = [
    LocaleKeys.lecture.tr(),
    LocaleKeys.video.tr(),
    LocaleKeys.Summary.tr(),
    LocaleKeys.questions.tr()
  ];

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
  void initState() {
  AppCubit.get(context).getLectureData(subjectName:subjectName,academicYear:academicYear ,lectureName: lectureName );

super.initState();
  }
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
                      fontSize: MediaQuery.of(context).size.width * 0.06)),
            ),
            body: Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              4, (index) => tabBuilder(index, cubit, context))),
                      Expanded(
                        child: cubit.lectureScreen[cubit.weekTemplateCurrentIndex],
                      )
                    ]))

          );
        });
  }
@override
  void dispose() {
cubit.locked=[false,false,false,true];
    super.dispose();
  }
  Widget tabBuilder(int index, AppCubit cuibt, context) {
    return InkWell(
      onTap: () {
        if (cuibt.locked[index] == true) {
          cubit.weekTemplateChangeIndex(index);
        } else {
          if(cuibt.getIfPayed(index)==true) {
            showDialog(
            context: context,
            builder: (context)=> AlertDialog(
              title: const Text(
                'pay it for unlock',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.teal,
                ),
              ),
              elevation: 10,
              content:  Text(
                'you will pay ${cuibt.getPoint(index)} point to unlock this lecture',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.secure(index: index,context: context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ],
            ),
          );
          }
          else {
            cubit.weekTemplateChangeIndex(index);
          }
        }
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
              condition: !cuibt.locked[index],
              fallback: (context) {
                return const Center(
                    child: Icon(
                  Icons.lock_open_outlined,
                  size: 20,
                ));
              },
              builder: (context) {
                return const Center(
                    child: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                ));
              })
        ],
      ),
    );
  }
}
