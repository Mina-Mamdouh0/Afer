import 'package:afer/const/colors_manger.dart';
import 'package:afer/const/photo_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/screens/Settings.dart';
import 'package:afer/screens/disconnected.dart';
import 'package:afer/screens/message_screen.dart';
import 'package:afer/screens/payment_screen.dart';
import 'package:afer/screens/subjects_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../translations/locale_keys.g.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  double bottomNavBarHeight = 60;
  late List<TabItem> tabItems;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).navigationController = CircularBottomNavigationController(   AppCubit.get(context).selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          tabItems = List.of([
            TabItem(IconlyLight.home, LocaleKeys.home.tr(), Colors.blue,
                labelStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                )),
            TabItem(
              IconlyLight.activity,
              LocaleKeys.news.tr(),
              Colors.orange,
              labelStyle: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.normal,
              ),
            ),
            TabItem(IconlyLight.message, LocaleKeys.messages.tr(), Colors.red,
                labelStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.normal,
                )),
            TabItem(IconlyLight.setting, LocaleKeys.setting.tr(), Colors.cyan,
                labelStyle: const TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.normal,
                )),
          ]);
          var cubit = BlocProvider.of<AppCubit>(context);
          return ConditionalBuilder(
              fallback: (context) => Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator())),
              condition: cubit.user.firstName != null,
              builder: (context) {
                return ConnectionNotifierToggler(
                  connected: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      centerTitle: true,
                      toolbarHeight: size.height * 0.14,
                      leadingWidth: size.width * 0.18,
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
                                height: size.height * 0.135,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: ColorsManger.appbarColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.25,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          "${cubit.user.firstName!} ${cubit.user.secondName!}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Stoor',
                                            fontSize: size.width * 0.035,
                                          ),
                                        ),
                                        Text(
                                          cubit.user.academicYear!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Stoor',
                                            fontWeight: FontWeight.normal,
                                            fontSize: size.width * 0.035,
                                          ),
                                        ),
                                        Text(
                                          cubit.user.points!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Stoor',
                                            fontWeight: FontWeight.normal,
                                            fontSize: size.width * 0.035,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        navigator(
                                            context: context,
                                            page: const PaymentScreen(),
                                            returnPage: true);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: CircleAvatar(
                                          radius: size.width * 0.05,
                                          backgroundImage: const AssetImage(
                                              PhotoManger.coins),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: size.height * 0.01,
                            right: context.locale == const Locale('en')
                                ? null
                                : size.width * 0.025,
                            left: context.locale == const Locale('en')
                                ? size.width * 0.025
                                : null,
                            child: CircleAvatar(
                              radius: size.width * 0.11,
                              backgroundColor: ColorsManger.appbarColor,
                              child: CachedNetworkImage(
                                imageUrl: cubit.user.profileUrl!,
                                cacheKey: cubit.user.profileUrl,

                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  radius: size.width * 0.09,
                                  backgroundImage: imageProvider,
                                  backgroundColor: Colors.white,
                                  onBackgroundImageError: (exception, stackTrace) {},
                                  child: cubit.user.profileUrl == null
                                      ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.black,
                                  )
                                      : null,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    body: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: bottomNavBarHeight),
                          child: bodyContainer(),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: bottomNav())
                      ],
                    ),
                  ),
                  disconnected: const DisConnected(),

                );
              });
        });
  }

  Widget bodyContainer() {
    Widget screen;
    switch (   AppCubit.get(context).selectedPos) {
      case 0:
        screen = const SubjectsScreen();
        break;
      case 1:
        screen = const MessageScreen();
        break;
      case 2:
        screen = const MessageScreen();
        break;
      case 3:
        screen = Setting();
        break;
      default:
        screen = Container();
        break;
    }

    return GestureDetector(
      child: screen,
      onTap: () {
        if (   AppCubit.get(context).navigationController.value == tabItems.length - 1) {
             AppCubit.get(context).navigationController.value = 0;
        } else {
             AppCubit.get(context).navigationController.value =    AppCubit.get(context).navigationController.value! + 1;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller:    AppCubit.get(context).navigationController,
      selectedPos:    AppCubit.get(context).selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
           AppCubit.get(context).selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    AppCubit.get(context).navigationController.dispose();
  }
}
