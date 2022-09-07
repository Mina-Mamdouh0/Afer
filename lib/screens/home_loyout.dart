import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/photo_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import '../translations/locale_keys.g.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>
      (
     listener: (context,state){},
     builder: (context,state)
     {
       var cubit=BlocProvider.of<AppCubit>(context);
             return  Scaffold(
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
                                    Text('الفرقه الاولي',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: size.width*0.035,
                                      ),),
                                    Text('5 نقط',
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
                            backgroundImage: AssetImage(PhotoManger.profilepic),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                 body: cubit.screens[cubit.currentIndex],
                 bottomNavigationBar:SlidingClippedNavBar(
                 activeColor: ColorsManger.iconsBackgroundColor,
                 barItems: [
                    BarItem(
                      icon: IconlyLight.home,
                      title: LocaleKeys.home.tr(),
                    ),
                    BarItem(
                      icon: IconlyLight.activity,
                     title: LocaleKeys.news.tr(),
                    ),
                    BarItem(
                      icon: IconlyLight.message,
                      title: LocaleKeys.messages.tr(),
                    ),
                    BarItem(
                      icon: IconlyLight.setting,
                      title: LocaleKeys.setting.tr(),
                    ),
                  ],
                 onButtonPressed: (index) {
                   cubit.changeIndex(index);
                 },
                 selectedIndex: cubit.currentIndex,
                 backgroundColor: Colors.white,
                 inactiveColor: ColorsManger.appbarColor,
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 iconSize: 35,

               )
              );
            });
  }

}
