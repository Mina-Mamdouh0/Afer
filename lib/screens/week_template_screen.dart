

import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const/photo_manger.dart';
import '../translations/locale_keys.g.dart';

class WeekTemplateScreen extends StatelessWidget {
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
//LocaleKeys.lecture.tr())
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
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
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(4, (index) => tabBuilder(index))),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: cubit.weekTemplatePageController,
                      children: cubit.weekTemplatescreens,
                    ),
                  )
                ])),
          );
        });
  }

  Widget tabBuilder(int index) {
    return InkWell(
      onTap: () {
        cubit.weekTemplateChangeIndex(index);
      },
      child: Container(
        child: Column(
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
            SizedBox(
              height: 5,
            ),
            Text(
              weekDetails[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
