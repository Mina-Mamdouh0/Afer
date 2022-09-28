
import 'package:afer/const/colors_manger.dart';
import 'package:afer/widget/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShowQuestion extends StatefulWidget {
  @override
  State<ShowQuestion> createState() => _ShowQuestionState();
}

class _ShowQuestionState extends State<ShowQuestion> {

  int pageIndex = 1;
  List<bool> buttonsStates = [false, false, false];

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "السؤال",
                style: TextStyle(
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
              const Padding(
                padding:  EdgeInsets.only(top: 10, right: 10),
                child: Text(
                  "/ 3",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            "ما هو خذا السوال",
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                buttonsStates[0] = true;
                buttonsStates[1] = false;
                buttonsStates[2] = false;
              });
            },
            child: QuestionCard(
              text:
              "سسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسسةل الاةل",
              ischecked: buttonsStates[0],
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              setState(() {
                buttonsStates[0] = false;
                buttonsStates[1] = true;
                buttonsStates[2] = false;
              });
            },
            child: QuestionCard(
              text:
              "The user experience is how the user feels about interacting with or experiencing a product.",
              ischecked: buttonsStates[1],
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              setState(() {
                buttonsStates[0] = false;
                buttonsStates[1] = false;
                buttonsStates[2] = true;
              });
            },
            child: QuestionCard(
              text:
              "The user experience is the attitude the UX designer has about a product.",
              ischecked: buttonsStates[2],
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
                  text: "السابق",
                  fct: () {
                    setState(() {
                      pageIndex--;
                    });
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: MainButton(
                  text: pageIndex >= 3 ? "انهاء" : "التالي",

                  fct: () {
                    if (pageIndex >= 3) {
                      //routes to screen
                    } else {
                      setState(() {
                        pageIndex++;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  String text;
  bool ischecked;
  QuestionCard({required this.text, required this.ischecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManger.appbarColor.withOpacity(0.8), width: 2),
        color: const Color.fromRGBO(252, 252, 252, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                ischecked
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
