import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/auth/signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../const/photo_manger.dart';
import '../../translations/locale_keys.g.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  int indd = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(PhotoManger.aferLogo),
              backgroundColor: Colors.transparent,
            ),
            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Text(
                LocaleKeys.welcome.tr(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFEEEEEE),
            elevation: 0,
            toolbarHeight: 215,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: TabBar(
                              indicatorWeight: 3,
                              indicatorSize: TabBarIndicatorSize.label,
                              onTap: (ind) {
                                indd = ind;
                                setState(() {});
                              },
                              indicatorColor: Colors.blue[700],
                              tabs: [
                                Text(
                                  LocaleKeys.signIn.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  LocaleKeys.signUp.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: TabBarView(children: [
                            Form(
                              key:cuibt.SignInFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  /*Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Regiter with',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.mail))),
                                      const Text(
                                        'or',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.facebook))),
                                      const Text(
                                        'or',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.phone))),
                                    ],
                                  ),*/
                                  TextFormField(
                                      controller: cuibt.emailSignInController,
                                      decoration: InputDecoration(
                                        hintText: '*****@gmail.com',
                                        labelText: LocaleKeys.emailHint.tr(),

                                      ),
                                    validator: (value){
                                        if(value!.isEmpty&&value.contains("@")){
                                          return LocaleKeys.emailHint.tr();
                                        }
                                        return null;
                                    },
keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,

                                  ),
                                  TextFormField(
                                      controller: cuibt.passwordSignInController,
                                      decoration: InputDecoration(
                                        suffixIcon:IconButton(
                                          icon:cuibt.isObscureSignIn? Icon(Icons.visibility_off):Icon(Icons.visibility),
                                          onPressed: ()=> cuibt.changeObscureSignIn(),
                                        ),

                                        hintText: '**********',
                                        labelText: LocaleKeys.password.tr(),
                                      ),
                                  obscureText: cuibt.isObscureSignIn,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return LocaleKeys.password.tr();
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value){
                                      if(cuibt.SignInFormKey.currentState!.validate()) {
                                        cuibt.signIn(context);
                                      }
                                    },

                                  ),
                                  CheckboxListTile(
                                      value: cuibt.rememberMe,
                                      onChanged: (value) =>
                                          cuibt.toggleRememberMe(value),
                                      title: Text(LocaleKeys.rememberMe.tr())),
                                  Container(
                                      alignment: Alignment.bottomLeft,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                              LocaleKeys.forgetPassword.tr()))),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    padding: const EdgeInsets.all(18),
                                    onPressed: () {
                                     if(cuibt.SignInFormKey.currentState!.validate()) {
                                       cuibt.signIn(context);
                                     }
                                    },
                                    color: Colors.blue[700],
                                    minWidth: double.infinity,
                                    child: Text(
                                      LocaleKeys.signIn.tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SignupScreen(),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
