import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  const LectureScreen(
      {Key? key,
      required this.subjectName,
      required this.academicYear,
      required this.lectureName})
      : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  _LectureScreenState();

  List<Map<String, dynamic>> weekDetails = [
    {
      'name': LocaleKeys.read.tr(),
      'image': Icons.receipt_outlined,
    },
    {
      'name': LocaleKeys.listen.tr(),
      'image': Icons.video_call_outlined,
    },
    {
      'name': LocaleKeys.training.tr(),
      'image': Icons.edit,
    },
    {
      'name': LocaleKeys.alerts.tr(),
      'image': Icons.menu_book_sharp,
    },
    {
      'name': LocaleKeys.feedback.tr(),
      'image': Icons.feedback,
    },
  ];

  late AppCubit cubit;

  @override
  void initState() {
    AppCubit.get(context).locked = [false, false, true, true, true];
    AppCubit.get(context).getAllSucre();
    AppCubit.get(context).subjectName = widget.subjectName;
    AppCubit.get(context).lectureName = widget.lectureName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = AppCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                toolbarHeight: size.height * 0.22,
                leadingWidth: size.width * 0.18,
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                leading: Container(),
                flexibleSpace: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: size.height * 0.135,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: ColorsManger.appbarColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: size.width * 0.25,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Text(
                                    "${cubit.user.firstName!} ${cubit.user.secondName!}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Stoor',
                                      fontSize: size.width * 0.035,
                                    ),
                                  ),
                                  Text(
                                    cubit.user.academicYear!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Stoor',
                                      fontWeight: FontWeight.normal,
                                      fontSize: size.width * 0.035,
                                    ),
                                  ),
                                  Text(
                                    cubit.user.points!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Stoor',
                                      fontWeight: FontWeight.normal,
                                      fontSize: size.width * 0.035,
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  navigator(
                                      context: context,
                                      page: const PaymentScreen(),
                                      returnPage: true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: CircleAvatar(
                                    radius: size.width * 0.05,
                                    backgroundImage:
                                        const AssetImage(PhotoManger.coins),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.2,
                                  ),
                                  ...List.generate(
                                      weekDetails.length,
                                      (index) => Expanded(
                                          child: tabBuilder(
                                              index, cubit, context)))
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: size.height * 0.08,
                      right: context.locale == const Locale('en')
                          ? null
                          : size.width * 0.015,
                      left: context.locale == const Locale('en')
                          ? size.width * 0.015
                          : null,
                      child: CircleAvatar(
                        radius: size.width * 0.11,
                        backgroundColor: ColorsManger.appbarColor,
                        child: CachedNetworkImage(
                          imageUrl: cubit.user.profileUrl!,
                          cacheKey: cubit.user.profileUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: size.width * 0.09,
                            backgroundImage: imageProvider,
                            backgroundColor: Colors.white,
                            onBackgroundImageError: (exception, stackTrace) {},
                            child: cubit.user.profileUrl == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: cubit.lectureScreen[cubit.weekTemplateCurrentIndex],
              ));
        });
  }

  @override
  void dispose() {
    cubit.locked = [false, false, true, true, true];
    cubit.studentNotes.clear();
    super.dispose();
  }

  Widget tabBuilder(int index, AppCubit cubit, context) {
    return InkWell(
      onTap: () async {
        if (AppCubit.get(context).locked[index] == true ||
            AppCubit.get(context).user.premium == true) {
          if (index == 1) {
            BlocProvider.of<AppCubit>(context).showImageUnderVideo = false;
          }
          AppCubit.get(context).weekTemplateChangeIndex(index);
        } else {
          if (await AppCubit.get(context).getIfPayed(index) == true) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  LocaleKeys.payTitle.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.teal,
                  ),
                ),
                elevation: 10,
                content: Text(
                  '${LocaleKeys.youWillPay.tr()} ${cubit.getPoint(index)} ${LocaleKeys.pointLecture.tr()}',
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
                      child: Text(
                        LocaleKeys.cancel.tr(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.secure(index: index, context: context);
                      },
                      child: Text(
                        LocaleKeys.yes.tr(),
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ],
              ),
            );
          } else {
            cubit.weekTemplateChangeIndex(index);
          }
        }
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 60,
            //color: Colors.pinkAccent,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: cubit.weekTemplateCurrentIndex == index
                      ? const Color(0XFF9C3A44)
                      : ColorsManger.appbarColor,
                  child: CircleAvatar(
                    backgroundColor: (cubit.weekTemplateCurrentIndex == index)
                        ? const Color(0XFF9C3A44)
                        : Colors.white,
                    radius: 18,
                    child: Center(
                        child: Icon(
                      weekDetails[index]['image'],
                      color: cubit.weekTemplateCurrentIndex == index
                          ? Colors.white
                          : ColorsManger.appbarColor,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Text(
                    weekDetails[index]['name'],
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontFamily: 'Stoor',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          ConditionalBuilder(
              condition: cubit.locked[index] || cubit.user.premium == true,
              builder: (context) {
                return Container();
              },
              fallback: (context) {
                return const Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                );
              })
        ],
      ),
    );
  }
}
