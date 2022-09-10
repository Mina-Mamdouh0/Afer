
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/screens/spalsh_screen.dart';
import 'package:afer/translations/codegen_loader.g.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afer/SheredPreferance/sheredHelper.dart';

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
 //await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
 await Firebase.initializeApp();
 await sherdprefrence.init();
 await EasyLocalization.ensureInitialized();

 runApp(
   EasyLocalization(
       supportedLocales: const [Locale('en'), Locale('ar')],
       path: 'Asset/translition',
       fallbackLocale: const Locale('en'),
       assetLoader: const CodegenLoader(),
       child: const MyApp()
   )
 );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      child:  BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Afer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home:  const SplashScreen() ,
        ),
      ),
    );
  }


}

