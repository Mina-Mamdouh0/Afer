import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/constant_texts.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/screens/week_template_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../widget/widget.dart';
import '../const/photo_manger.dart';
import '../translations/locale_keys.g.dart';
//title: LocaleKeys.selectSubject.tr()
class WeeksScreen extends StatelessWidget {
  Map data;
  WeeksScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        var cuibt = AppCubit.get(context);
        List<String> weeks = [
          LocaleKeys.firstWeek.tr(),
          LocaleKeys.second.tr(),
          LocaleKeys.third.tr(),
          LocaleKeys.fourth.tr(),
          LocaleKeys.fifty.tr(),
          LocaleKeys.six.tr()
        ];
        return Scaffold(
          appBar:AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: size.height*0.14,
            leadingWidth: size.width * 0.18 ,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            flexibleSpace: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: size.height*0.135,
                      width: double.infinity,
                      decoration:   BoxDecoration(
                        color: ColorsManger.appbarColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: size.width*0.25,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Text('محمد احمد سعداني',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width*0.035,
                                ),),
                              Text('طالب : الفؤقه الاولي',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width*0.035,
                                ),),
                              Text('اجمالي النقط : نقط',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width*0.035,
                                ),)
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              navigator(context: context, page: PaymentScreen(), returnPage: true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircleAvatar(
                                radius: size.width*0.05,
                                backgroundImage: AssetImage(PhotoManger.coins),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),

                  ],
                ),
                Positioned(
                  bottom: size.height*0.01,
                  right: context.locale==const Locale('en')?null:size.width*0.025,
                  left:context.locale==const Locale('en')? size.width*0.025:null,
                  child: CircleAvatar(
                    radius: size.width*0.11,
                    backgroundColor: ColorsManger.appbarColor,
                    child: CircleAvatar(
                      radius: size.width*0.09,
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          body:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 0.7,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                double opacity = data["${week[index]} week"] ? 1.0 : 0.5;
                return InkWell(
                  onTap: () {
                    if (cuibt.beSurePayment(
                        index: index, week: data["${week[index]} week"])) {
                      cuibt.getWeekData(
                        week: "${week[index]} week",
                        academicYear: "First Year",
                        subjectName: data["name"],
                      );
                      navigator(
                          context: context,
                          page: WeekTemplateScreen(),
                          returnPage: true);
                    } else {
                      MotionToast.error(
                        description:  Text(
                            LocaleKeys.moneyHint.tr()
                        ),
                        title:  Text(
                            LocaleKeys.moneyHint1.tr()),
                        height: 100,
                        width: 350,
                        animationDuration: const Duration(milliseconds: 900),
                        borderRadius: 25,
                        barrierColor: Colors.black.withOpacity(0.5),
                        position: MotionToastPosition.bottom,
                        toastDuration: const Duration(
                          milliseconds: 600,
                        ),
                        animationType: AnimationType.fromBottom,
                      ).show(context);
                    }
                  },
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    top: 20, end: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, -3), //(x,y)
                                        blurRadius: 6.0),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.weeks.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    end: 25, start: 5),
                                alignment: Alignment.center,
                                color: Color.fromRGBO(148, 0, 55, opacity),
                                child: Text(
                                  weeks[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                              backgroundColor: Color.fromRGBO(148, 0, 55, 1),
                              radius: 20,
                              child: data["${week[index]} week"]
                                  ? Icon(
                                Icons.lock_open,
                                color: Colors.white,
                              )
                                  : Image(
                                image: AssetImage(PhotoManger.lock),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: 6,
            ),
          ),
        );
      },
    );
  }
}
