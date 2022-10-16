import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cuibt/app_cuibt.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  bool isEnterOrEdit = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ConditionalBuilder(
              condition: context.read<AppCubit>().studentNotes.isEmpty,
              fallback: (context) => Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.62,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment:
                                            context.locale == const Locale('ar')
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                        child: Text(
                                            cubit.studentNotes[index].notes!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Rajab',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.055,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            backgroundImage: NetworkImage(
                                                cubit.user.profileUrl!),
                                            backgroundColor: Colors.white,
                                            onBackgroundImageError:
                                                (exception, stackTrace) {},
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            cubit.studentNotes[index].date ??
                                                "",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              fontFamily: 'Stoor',
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            alignment: Alignment.bottomRight,
                                            icon: const Icon(
                                              Icons.edit,
                                              color: ColorsManger.appbarColor,
                                            ),
                                            onPressed: () =>cubit.toggleNotesShow(true, cubit.studentNotes[index].uid!)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: cubit.studentNotes.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MainButton(
                        fct: () => cubit.toggleNotesShow(false,""),
                        text: LocaleKeys.enterMoreNotes.tr(),
                      ),
                    ],
                  ),
              builder: (context) {
                return ListView(
                  children: [
                    TheTextFiled(
                      controller: controller,
                      hintText: LocaleKeys.feedback.tr(),
                      keyboardType: TextInputType.text,
                      prefix: 1,
                      maxLine: 12,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MainButton(
                      fct: () {
                        BlocProvider.of<AppCubit>(context).uploadOrUpdateNotes(
                          controller.text,
                        );
                        BlocProvider.of<AppCubit>(context).getNote();
                        controller.clear();
                      },
                      text: LocaleKeys.confirm.tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MainButton(
                      fct: () =>cubit.getNote(),
                      text: LocaleKeys.showNotes.tr(),
                    ),

                  ],
                );
              });
        },
      ),
    );
  }
}
