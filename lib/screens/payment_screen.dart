
import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/photo_manger.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class PaymentScreen extends StatelessWidget {
   PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: ColorsManger.appbarColor,
              title: Text(LocaleKeys.points.tr(),
                  style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width*0.06
              )),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 100,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage(PhotoManger.coins),width: 50,),
                      Text('your coins now',style: TextStyle(color: Colors.red,fontSize: 22),)
                    ],),
                  const Spacer(),
                  BarcodeWidget(
                    data:'minaminaminaminaminaminaminaminaminaminamina',
                    barcode: Barcode.qrCode(),
                    color: Colors.black,
                    height: size.width*0.5,
                    width:  size.width*0.5,
                  ),
                  const Spacer(),
                  MainButton(
                fct: (){
                  /*try{
                            FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value){
                              BlocProvider.of<AppCubit>(context).readQrCode(value);
                            });
                          }catch(e){
                            BlocProvider.of<AppCubit>(context).readQrCode('unable to read this');
                          }*/
                },
                text:'Scan barcode' ,
              ),
                ],
              ),
            ),
          );

  }

}
