import 'package:afer/const/colors_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../translations/locale_keys.g.dart';

List<bool> buttonsStates = [false, false, false, false];

class ShowQuestion extends StatefulWidget {
  const ShowQuestion({super.key});

  @override
  State<ShowQuestion> createState() => _ShowQuestionState();
}

class _ShowQuestionState extends State<ShowQuestion> {
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: AppCubit.get(context).questions.isNotEmpty,
              fallback: (context) => Center(
                    child: Text(
                      LocaleKeys.noQuestionsYet.tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'Stoor',
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              builder: (context) {
                return ListView(

                  children: [
                    Row(
                      children: [
                        Text(
                          LocaleKeys.question.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          pageIndex.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: ColorsManger.appbarColor.withOpacity(0.8),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Text(
                            AppCubit.get(context).questions.length.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      AppCubit.get(context).questions[pageIndex - 1].question!,
                      maxLines: 5,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          fontFamily: "AdvertisingExtraBold"),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          buttonsStates[0] = true;
                          buttonsStates[1] = false;
                          buttonsStates[2] = false;
                          buttonsStates[3] = false;
                        });
                      },
                      child: QuestionCard(
                        text: AppCubit.get(context)
                            .questions[pageIndex - 1]
                            .answer1!,
                        isChecked: buttonsStates[0],
                        isCorrect: AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .answer1 ==
                            AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .correctAnswer,
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        setState(() {
                          buttonsStates[0] = false;
                          buttonsStates[1] = true;
                          buttonsStates[2] = false;
                          buttonsStates[3] = false;
                        });
                      },
                      child: QuestionCard(
                        text: AppCubit.get(context)
                            .questions[pageIndex - 1]
                            .answer2!,
                        isChecked: buttonsStates[1],
                        isCorrect: AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .answer2 ==
                            AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .correctAnswer,
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        setState(() {
                          buttonsStates[0] = false;
                          buttonsStates[1] = false;
                          buttonsStates[2] = true;
                          buttonsStates[3] = false;
                        });
                      },
                      child: QuestionCard(
                        text: AppCubit.get(context)
                            .questions[pageIndex - 1]
                            .answer3!,
                        isChecked: buttonsStates[2],
                        isCorrect: AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .answer3 ==
                            AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .correctAnswer,
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        setState(() {
                          buttonsStates[0] = false;
                          buttonsStates[1] = false;
                          buttonsStates[2] = false;
                          buttonsStates[3] = true;
                        });
                      },
                      child: QuestionCard(
                        text: AppCubit.get(context)
                            .questions[pageIndex - 1]
                            .answer4!,
                        isChecked: buttonsStates[3],
                        isCorrect: AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .answer4 ==
                            AppCubit.get(context)
                                .questions[pageIndex - 1]
                                .correctAnswer,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        pageIndex == 1
                            ? Expanded(flex: 1, child: Container())
                            : Expanded(
                                flex: 1,
                                child: MainButton(
                                  text: LocaleKeys.before.tr(),
                                  fct: () {
                                    setState(() {
                                      buttonsStates[0] = false;
                                      buttonsStates[1] = false;
                                      buttonsStates[2] = false;
                                      buttonsStates[3] = false;
                                      pageIndex--;
                                    });
                                  },
                                ),
                              ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: MainButton(
                            text: pageIndex >=
                                    AppCubit.get(context).questions.length
                                ? LocaleKeys.end.tr()
                                : LocaleKeys.next.tr(),
                            fct: () {
                              if (pageIndex >=
                                  AppCubit.get(context).questions.length) {
                                setState(() {
                                  buttonsStates[0] = false;
                                  buttonsStates[1] = false;
                                  buttonsStates[2] = false;
                                  buttonsStates[3] = false;
                                });
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  buttonsStates[0] = false;
                                  buttonsStates[1] = false;
                                  buttonsStates[2] = false;
                                  buttonsStates[3] = false;
                                  pageIndex++;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  String text;
  bool isChecked;
  bool isCorrect;

  QuestionCard({super.key,
    required this.text,
    required this.isChecked,
    this.isCorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: isChecked
          ? BoxDecoration(
              border: Border.all(
                  color: ColorsManger.appbarColor.withOpacity(0.8), width: 2),
              color: isCorrect ? Colors.teal : Colors.red,
              borderRadius: BorderRadius.circular(10),
            )
          : BoxDecoration(
              border: Border.all(
                  color: ColorsManger.appbarColor.withOpacity(0.8), width: 2),
              color: isCorrect && buttonsStates.contains(true)
                  ? Colors.teal
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: "Droid Arabic Naskh Bold"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Stack(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: ColorsManger.appbarColor.withOpacity(0.8),
                ),
                isChecked
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.brightness_1_rounded,
                          color: ColorsManger.appbarColor.withOpacity(0.8),
                          size: 20,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
