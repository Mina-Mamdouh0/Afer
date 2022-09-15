
import 'package:afer/const/photo_manger.dart';
import 'package:flutter/material.dart';


class NotPayed extends StatelessWidget {
  const NotPayed({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
           "you can watch this lecture ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign:  TextAlign.center,
          ),
          SizedBox(height: 15,),
          Text(
            "tap on the type of lecture you want to watch to pay it ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
           textAlign: TextAlign.center,
          ),
          SizedBox(height: 15,),
          Image(image: AssetImage(PhotoManger.sad),height: 100,width: 100,color: Colors.black),
        ],
      ),
    );
  }
}
