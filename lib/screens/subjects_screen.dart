import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/model/Subject.dart';
import 'package:afer/screens/week_details/lecture_screen.dart';
import 'package:afer/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../model/lecture.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return ConditionalBuilder(
          builder: (context) => ListView.builder(
            itemCount: cubit.subjects.length,
            padding: const EdgeInsets.all(5.0),
            itemBuilder: (context, index) =>
                SubjectWidget(subject: cubit.subjects[index]),
          ),
          fallback: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('Asset/Image/emptysubject.json', fit: BoxFit.fill),
              const Text(
                'Not found your Subjects please go setting to choose your subject',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          condition: cubit.subjects.isNotEmpty,
        );
      },
    );
  }
}

class SubjectWidget extends StatefulWidget {
  final Subject subject;
  const SubjectWidget({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectWidget> createState() => _SubjectWidgetState(subject: subject);
}

class _SubjectWidgetState extends State<SubjectWidget> {
  _SubjectWidgetState({required this.subject});
  final Subject subject;
  List<Lecture> lectures = [];
  @override
  void initState() {
    AppCubit.get(context).getMyLectures(subject: subject).then((value) {
      setState(() {
        lectures = value;
      });
    });

    print(lectures);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject.name!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: lectures.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap:() =>navigator(context: context,returnPage: true,page: LectureScreen(academicYear:subject.academicYear!,subjectName: subject.name!,lectureName:lectures[index].lectureName!),),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: context.locale == const Locale('ar')
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Text(lectures[index].lectureName!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: MediaQuery.of(context).size.width *
                                          0.08,
                                      backgroundImage:
                                          NetworkImage(subject.urlPhotoTeacher!),
                                      backgroundColor: Colors.white,
                                      onBackgroundImageError:
                                          (exception, stackTrace) {},
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(subject.teacherName!,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                            )),
                                        Row(
                                          children: List.generate(
                                              5,
                                              (index) => const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Text(lectures[index].lectureDescription!,
                                      softWrap: true,
                                      maxLines:
                                          context.locale == const Locale('ar')
                                              ? 1
                                              : 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        fontWeight: FontWeight.bold,
                                        overflow:
                                            context.locale == const Locale('ar')
                                                ? TextOverflow.visible
                                                : TextOverflow.ellipsis,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );

  }
}
