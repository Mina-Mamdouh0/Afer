

import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../const/photo_manger.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return ConditionalBuilder(
          builder: (context)=>
              ListView.builder(
                itemCount: 7,
                padding: const EdgeInsets.all(5.0),
                itemBuilder:(context,index)=> SubjectWidget(),
              ),
          fallback:(context)=>  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('Asset/Image/emptysubject.json',fit: BoxFit.fill),
              Text('Not found your Subjects please go setting to choose your subject',style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
            ],
          ),
          condition:true//cubit.subjects.length > 0,
        );


      },
    );
  }

}
class SubjectWidget extends StatelessWidget {
  const SubjectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.25,
      padding: const EdgeInsets.symmetric(horizontal: 5,),
      margin: const EdgeInsets.symmetric(vertical: 5,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.locale==const Locale('ar')?'اساسيات المحاسبه الماليه':'Fundamentals of financial accounting',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width*0.05,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: context.locale==const Locale('ar')?Alignment.centerLeft:Alignment.centerRight,
                              child: Text(context.locale==const Locale('ar')?'المحاضره الاولي':'Lecture One',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width*0.05,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.width*0.08,
                                  backgroundImage: AssetImage(PhotoManger.profilepic),
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(context.locale==const Locale('ar')?'محمد حسني':'Mahomed Hosni',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: MediaQuery.of(context).size.width*0.045,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.visible,
                                        )),
                                    Row(
                                      children: List.generate(5, (index) => Icon(Icons.star,
                                        color: Colors.amber,

                                      )),
                                    )
                                  ],
                                )
                              ],
                            ),

                            Expanded(
                              child: Text(context.locale==const Locale('ar')?'مقدمه حتي معادله الميزانيه الميزانيه الميزانيه':'Introduction to the budget equation budget budget',
                                  softWrap: true,
                                  maxLines: context.locale==const Locale('ar')?1:2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width*0.045,
                                    fontWeight: FontWeight.bold,
                                    overflow: context.locale==const Locale('ar')?TextOverflow.visible:TextOverflow.ellipsis,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
