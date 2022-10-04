import 'package:afer/const/constant_texts.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/model/Subject.dart';
import 'package:afer/screens/user_account_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../translations/locale_keys.g.dart';

class Setting extends StatelessWidget {
  late AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = AppCubit.get(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                buildItemSetting(
                    text: LocaleKeys.profile.tr(),
                    icons: Icons.perm_identity_rounded,
                    fct: () {
                      navigator(
                          context: context,
                          page: const UserAccountScreen(),
                          returnPage: true);
                    }),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                          child: ExpansionTile(
                              onExpansionChanged: (value) {
                                if (value) {}
                              },
                              tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              title: Text(
                                LocaleKeys.selectSubject.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              leading: const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                              children: [
                            generateSubExpansion(cubit.firstYear,
                                LocaleKeys.firstYear.tr(), "First Year"),
                            generateSubExpansion(cubit.secondYear,
                                LocaleKeys.secondYear.tr(), "Second Year"),
                            generateSubExpansion(cubit.thirdYear,
                                LocaleKeys.thirdYear.tr(), "Third Year"),
                            generateSubExpansion(cubit.fourthYear,
                                LocaleKeys.fourthYear.tr(), "Fourth Year"),
                            MainButton(
                                text: LocaleKeys.confirm.tr(),
                                fct: () {
                                  if (cubit.subjects.length <= 7) {
                                    cubit.chooseSubject();
                                    cubit.changeIndex(0);
                                  } else {
                                    MotionToast.error(
                                      description: const Text(
                                          "اعد اختيار موادك مره اخري"),
                                      title: const Text(
                                          "يجب ان يكون عدد المواد 7 مواد "),
                                      height: 100,
                                      width: 350,
                                      animationDuration:
                                          const Duration(milliseconds: 900),
                                      borderRadius: 25,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      position: MotionToastPosition.bottom,
                                      toastDuration: const Duration(
                                        milliseconds: 600,
                                      ),
                                      animationType: AnimationType.fromBottom,
                                    ).show(context);
                                  }
                                })
                          ]))
                    ],
                  ),
                ),
                buildItemSetting(
                    text: LocaleKeys.share.tr(),
                    icons: Icons.share,
                    fct: () {}),
                buildItemSetting(
                    text: LocaleKeys.technicalSupport.tr(),
                    icons: Icons.biotech,
                    fct: () {}),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                          child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              title: Text(
                                LocaleKeys.languages.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              leading: const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  child: Icon(
                                    Icons.translate,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                              children: List.generate(
                                  2,
                                  (index) => generateLanguageListTile(
                                      context, index)))),
                    ],
                  ),
                ),
                buildItemSetting(
                    text: LocaleKeys.signOut.tr(),
                    icons: Icons.logout,
                    fct: () {
                      showDialog(
                          context: context,
                          builder: (m) {
                            return AlertDialog(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  [
                                  const     Icon(
                                    Icons.logout,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  const  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    LocaleKeys.signOut.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              content:  Text(
                                LocaleKeys.wantSignOut.tr(),
                                style:const TextStyle(fontSize: 15),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.canPop(m)
                                          ? Navigator.pop(m)
                                          : null;
                                    },
                                    child:  Text(
                                      LocaleKeys.cancel.tr(),
                                      style: const TextStyle(
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      cubit.signOut(context);
                                      Navigator.pop(m);

                                    },
                                    child:  Text(
                            LocaleKeys.yes.tr(),
                                      style: const TextStyle(color: Colors.red),
                                    ))
                              ],
                            );
                          });
                    }),
              ],
            ),
          );
        });
  }

  Widget buildItemSetting({
    required IconData icons,
    required String text,
    required Function() fct,
  }) {
    return InkWell(
      onTap: fct,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
                radius: 18,
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(
                  icons,
                  color: Colors.white,
                  size: 20,
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15))),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.grey.shade700,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  ListTile generateLanguageListTile(BuildContext context, index) {
    return ListTile(
      selectedTileColor: Colors.deepPurpleAccent,
      selected: context.locale.toString() == "ar" ? index == 0 : index == 1,
      title: Text(languages[index],
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onTap: () {
        if (index == 0) {
          cubit.changeLocale(context, const Locale("ar"));
        } else {
          cubit.changeLocale(context, const Locale("en"));
        }
      },
    );
  }

  ExpansionTile generateSubExpansion(List<Subject> year, title, nameYear) {
    return ExpansionTile(
        onExpansionChanged: (value) {
          cubit.getAllSubject(nameYear, cubit.semester);
        },
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        expandedAlignment: Alignment.centerRight,
        children: [
          SizedBox(
              height: 300,
              width: 500,
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      generateCheckListTile(year[index], title, index),
                  separatorBuilder: (context, _) => const SizedBox(height: 5),
                  itemCount: year.length)),
        ]);
  }

  CheckboxListTile generateCheckListTile(
    Subject subject,
    String year,
    int index,
  ) {
    return CheckboxListTile(
      value: cubit.sureSubject(subject),
      onChanged: (value) {
        cubit.addSubject(year, subject, value, index);
      },
      title: Text(subject.name!, style: const TextStyle(fontSize: 15)),
      controlAffinity: ListTileControlAffinity.trailing,
      checkColor: Colors.black,
      activeColor: Colors.green,
    );
  }
}
