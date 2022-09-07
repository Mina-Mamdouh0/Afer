import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/constant_texts.dart';
import 'package:afer/const/photo_manger.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'home_loyout.dart';

class GroupsScreen extends StatelessWidget {

  const GroupsScreen({Key? key}) : super(key: key);
//اختار فرقتك
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.max,
        children: [
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(50),
            crossAxisSpacing: 30,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: List.generate(groups.length, (index) => year(text: groups[index],context: context)),
          ),
        ],
      ),
    );

  }
  Widget year({required String text,required BuildContext context}) {
    return InkWell(
      onTap: ()=> navigator(context: context,page: HomeLayout(),returnPage: false),
      child: Container(
          alignment: Alignment.center,
          decoration:BoxDecoration(borderRadius: BorderRadius.circular(15),color: const Color.fromRGBO(36, 136, 124,1),),
          child: Text(text,style: const TextStyle(fontSize: 40,color:Colors.white,fontWeight: FontWeight.bold),)
      ),
    );
  }

}
