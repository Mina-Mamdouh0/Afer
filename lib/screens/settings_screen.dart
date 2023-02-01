import 'package:afer/const/constant_texts.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/model/subject.dart';
import 'package:afer/screens/user_account_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../translations/locale_keys.g.dart';
import 'package:flutter/services.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

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
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        title: Text(
                          LocaleKeys.semester.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        leading: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: 15,
                            )),
                        children: [
                          Column(children: [
                            RadioListTile(
                              value: "First semester",
                              title:Text(LocaleKeys.semester1.tr()) ,
                              onChanged: (value) {
                                cubit.changeSemester(value);

                              },
                              groupValue: cubit.semester,
                            ),
                            RadioListTile(
                              value: "Second semester",
                              title:Text(LocaleKeys.semester2.tr()) ,
                              onChanged: (value) {
                                cubit.changeSemester(value);

                              },
                              groupValue: cubit.semester,
                            ),
                          ]),
                        ],
                      )),
                    ],
                  ),
                ),
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
                                LocaleKeys.firstYear.tr(), "First Year", cubit),
                            generateSubExpansion(
                                cubit.secondYear,
                                LocaleKeys.secondYear.tr(),
                                "Second Year",
                                cubit),
                            generateSubExpansion(cubit.thirdYear,
                                LocaleKeys.thirdYear.tr(), "Third Year", cubit),
                            generateSubExpansion(
                                cubit.fourthYear,
                                LocaleKeys.fourthYear.tr(),
                                "Fourth Year",
                                cubit),
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
                    fct: () {
                      cubit.shareApp();
                    }),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(children: [
                      Expanded(
                          child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        title: Text(
                          LocaleKeys.technicalSupport.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        leading: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Icon(
                              Icons.biotech,
                              color: Colors.white,
                              size: 15,
                            )),
                        children: [
                          Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "afeercorporate@gmail.com",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(const ClipboardData(
                                          text: "afeercorporate@gmail.com"))
                                      .then((value) => MotionToast.success(
                                            title: Text(LocaleKeys.copy.tr()),
                                            description: Text(
                                                "${LocaleKeys.emailHint.tr()} ${LocaleKeys.copy.tr()}"),
                                            height: 100,
                                            width: 350,
                                            animationDuration: const Duration(
                                                milliseconds: 900),
                                            borderRadius: 25,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            position:
                                                MotionToastPosition.bottom,
                                            toastDuration: const Duration(
                                              milliseconds: 600,
                                            ),
                                            animationType:
                                                AnimationType.fromBottom,
                                          ).show(context));
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.grey,
                                ))
                          ]),
                        ],
                      ))
                    ])),
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
                                      context, index, cubit)))),
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
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  const SizedBox(
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
                              content: Text(
                                LocaleKeys.wantSignOut.tr(),
                                style: const TextStyle(fontSize: 15),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.canPop(m)
                                          ? Navigator.pop(m)
                                          : null;
                                    },
                                    child: Text(
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
                                    child: Text(
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

  ListTile generateLanguageListTile(BuildContext context, index, cubit) {
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

  ExpansionTile generateSubExpansion(
      List<Subject> year, title, nameYear, AppCubit cubit) {
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
                      generateCheckListTile(year[index], title, index, cubit),
                  separatorBuilder: (context, _) => const SizedBox(height: 5),
                  itemCount: year.length)),
        ]);
  }

  CheckboxListTile generateCheckListTile(
    Subject subject,
    String year,
    int index,
    AppCubit cubit,
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
