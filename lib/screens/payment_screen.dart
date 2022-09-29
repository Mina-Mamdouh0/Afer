import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/photo_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: ColorsManger.appbarColor,
              title: Text(LocaleKeys.points.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.06)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Image(
                        image: AssetImage(PhotoManger.coins),
                        width: 50,
                      ),
                      Text(
                        BlocProvider.of<AppCubit>(context).user.points!,
                        style: TextStyle(color: Colors.red, fontSize: 22),
                      )
                    ],
                  ),
                  const Spacer(),
                  Lottie.asset(
                    PhotoManger.qrCode,
                    fit: BoxFit.fill,
                    height: size.width * 0.8,
                    width: size.width * 0.8,
                  ),
                  const Spacer(),
                  MainButton(
                    fct: () {
                      try {
                        FlutterBarcodeScanner.scanBarcode(
                                '#2A99CF', 'cancel', true, ScanMode.QR)
                            .then((value) {
                          BlocProvider.of<AppCubit>(context)
                              .readQrCode(value, context);
                        });
                      } catch (e) {
                        BlocProvider.of<AppCubit>(context)
                            .readQrCode('unable to read this', context);
                      }
                    },
                    text: 'Scan barcode',
                  ),
                ],
              ),
            ),
          );
        });
  }
}
