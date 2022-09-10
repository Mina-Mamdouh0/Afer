import 'dart:developer';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/model/Subject.dart';
import 'package:afer/screens/week_details/show_lecture.dart';
import 'package:afer/screens/week_details/show_question.dart';
import 'package:afer/screens/week_details/show_summary.dart';
import 'package:afer/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../screens/week_details/show_video.dart';
import '../model/UserModel.dart';
import '../model/pdf.dart';
import '../model/photo.dart';
import '../model/video.dart';
import '../screens/message_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home_loyout.dart';
import '../screens/Settings.dart';
import '../screens/subjects_screen.dart';
import 'package:afer/SheredPreferance/sheredHelper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AferInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  // Home Layout Screen variables
  UserModule? user;
  List<Widget> screens = [
    SubjectsScreen(),
    MessageScreen(),
    MessageScreen(),
    Setting()
  ];
  // Home Layout Screen variables

  List<Widget> lectureScreen = [
    ShowLecture(),
    ShowVideo(),
    ShowSummery(),
    ShowQuestion(),
  ];
  int currentIndex = 0;
  int indexRegisterScreen = 0;
  XFile? file;
  XFile? fileUpdate;

  void changeRegister(int newIndex){
    indexRegisterScreen=newIndex;
    emit(ChangeRegisterScreen());
  }

  void takeImage(XFile? newFile){
     file=newFile;
    emit(TakeImageSignUp());
  }
  void updateImage(XFile? newFile){
    fileUpdate=newFile;
    emit(UpdateImage());
  }

  var qrStar = "let's Scan it";
  // Home Layout Screen Functions
  void weekTemplateChangeIndex(int index) {
    weekTemplateCurrentIndex = index;
    emit(WeekTemplateChangeIndex());
  }

  int weekTemplateCurrentIndex = 0;

//signup account variables
  var userFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  bool isObscureSignup = true;
  var SignUpFormKey = GlobalKey<FormState>();

  //user Screen variables
  var userEmailController = TextEditingController();
  var usernameController = TextEditingController();
  var username2Controller = TextEditingController();
  var lastNameController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userConfirmPasswordController = TextEditingController();
  var userPhoneNumberController = TextEditingController();

//signIn Screen variables
  var emailSignInController = TextEditingController();
  var passwordSignInController = TextEditingController();
  bool rememberMe = false;
  List secondYear = [];
  List thirdYear = [];
  List fourthYear = [];
  String academicYear = "First year";
  bool isObscureSignIn = true;
var SignInFormKey = GlobalKey<FormState>();
  //Settings Screen variables
  List firstYear = [];
  List<Subject> subjects = [];
  Video? video;
  Photo? photo;
  Pdf? pdf;
  bool isObscureEditInfo = true;

  //Settings Screen Functions

  void changeObscure() {
    print(isObscureEditInfo);
    isObscureEditInfo = !isObscureEditInfo;
    emit(ChangeObscureState());
  }
  void changeObscureSignIn() {
    isObscureSignIn = !isObscureSignIn;
    emit(ChangeObscureState());
  }
  void changeObscureSignUp() {
    isObscureSignup = !isObscureSignup;
    emit(ChangeObscureState());
  }

  // Home Layout Screen Functions
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndex());
  }

  void pageChanged(int index) {
    currentIndex = index;
    emit(ChangeIndex());
  }

  void changeAcadimicYear(year) {
    academicYear = year;
    emit(ChangeAcademicYear());
  }

  void createAccount(uid) {
    UserModule user = UserModule(
        uid: uid,
        firstName: nameController.text,
        secondName: lastNameController.text,
        email: emailController.text,
        phone: int.parse(phoneNumberController.text),
        premium: false,
        profileUrl: "",
        pass: passwordController.text,
        semester: "First semester");
    print(uid);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(user.toJson())
        .then((value) {
      print("user created");
      emit(CreateAccountSuccess());
    }).catchError((error) {
      log(error.toString());
      emit(CreateAccountFailed());
    });
  }

  void getInfo(uid) {
    FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) {
      user = UserModule.fromJson(value.data()!);
      // add subjects to list to use it in subject screen to show subjects to user and get all data of subject
      subjects.clear();
      subjects.add(Subject.fromJson(value.data()!["FirstSubjects"]));
      subjects.add(Subject.fromJson(value.data()!["SecondSubjects"]));
      subjects.add(Subject.fromJson(value.data()!["thirdSubjects"]));
      subjects.add(Subject.fromJson(value.data()!["fourthSubjects"]));
      subjects.add(Subject.fromJson(value.data()!["fiftySubjects"]));
      subjects.add(Subject.fromJson(value.data()!["sixSubjects"]));
      subjects.add(Subject.fromJson(value.data()!["sevenSubjects"]));
      print(subjects.first.toJson());
      emit(GetUserInfoSuccess());
    }).catchError((error) {
      log(error.toString());
      emit(GetUserInfoFailed());
    });
  }

  void signUp(context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      print(value.user!.uid);
      createAccount(value.user!.uid);
      navigator(context: context, page: SignScreen(), returnPage: false);
    }).catchError((error) {
      log(error.toString());
      emit(CreateAccountFailed());
    });
  }

  void signIn(context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailSignInController.text,
            password: passwordSignInController.text)
        .then((value) {
      getInfo(value.user!.uid);
      if (rememberMe) {
        sherdprefrence.setdate(key: "token", value: value.user!.uid);
      }
      navigator(context: context, page: HomeLayout(), returnPage: false);
    }).catchError((error) {
      log(error.toString());
      MotionToast.error(
        description: const Text("حدث خطا ما في تسجيل الدخول"),
        title:
            const Text("تاكد من الاميل الاكتروني وكلمة المرور وحاول مره اخرى"),
        height: 100,
        width: 350,
        animationDuration: const Duration(milliseconds: 900),
        borderRadius: 25,
        barrierColor: Colors.black.withOpacity(0.5),
        position: MotionToastPosition.bottom,
        toastDuration: const Duration(
          milliseconds: 600,
        ),
        animationType: AnimationType.fromBottom,
      ).show(context);
    });
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      navigator(context: context, page: SignScreen(), returnPage: false);
      sherdprefrence.removedate(key: "token");
      emit(LogOut());
    });
  }

  void toggleRememberMe(value) {
    rememberMe = value;
    emit(ToggleRememberMe());
  }

  void ChooseSubject() {
    print(Subject);
    user = UserModule(
      uid: user!.uid,
      profileUrl: user!.profileUrl,
      firstName: user!.firstName,
      secondName: user!.secondName,
      email: user!.email,
      phone: user!.phone,
      premium: user!.premium,
      FirstSubjects: subjects[0].toJson(),
      SecondSubjects: subjects[1].toJson(),
      thirdSubjects: subjects[2].toJson(),
      fourthSubjects: subjects[3].toJson(),
      fiftySubjects: subjects[4].toJson(),
      sixSubjects: subjects[5].toJson(),
      sevenSubjects: subjects[6].toJson(),
      semester: user!.semester,
      pass: user!.pass,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(sherdprefrence.getdate(key: "token"))
        .update(user!.toJson())
        .then((value) {
      getInfo(sherdprefrence.getdate(key: "token"));
      changeIndex(0);
    }).catchError((onError) {
      log(onError.toString());
    });
  }

  void updateProfile() {
    updatePassword();
    user = UserModule(
      uid: user!.uid,
      profileUrl: user!.profileUrl,
      firstName: usernameController.text,
      secondName: username2Controller.text,
      email: user!.email,
      phone: int.parse(userPhoneNumberController.text),
      FirstSubjects: user!.FirstSubjects,
      SecondSubjects: user!.SecondSubjects,
      thirdSubjects: user!.thirdSubjects,
      fourthSubjects: user!.fourthSubjects,
      fiftySubjects: user!.fiftySubjects,
      sixSubjects: user!.sixSubjects,
      sevenSubjects: user!.sevenSubjects,
      premium: user!.premium,
      pass: userPasswordController.text,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(sherdprefrence.getdate(key: "token"))
        .update(user!.toJson())
        .then((value) {
      getInfo(sherdprefrence.getdate(key: "token"));
    }).catchError((onError) {});
  }

  void updatePassword() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user!.email!, password: user!.pass!)
        .then((value) {
      FirebaseAuth.instance.currentUser!
          .updatePassword(userPasswordController.text);
    });
  }
// to add new subject into map to get it from data base
  void MakeMapSubject(String Year, String NameSubject, value, int index) {
    if (value == false) {
   subjects.remove(subjects[index]);
    } else {
      subjects.insert(subjects.length, Subject(name: NameSubject, AcademicYear: Year,Semester: "first Semester",));
      print("add$subjects");
    }
    emit(MakeMapSubjectState());
  }
  // to make check box true or false
  bool SureSubject(String NameSubject) {
    bool? check=false ;
   // return Subject.containsKey(NameSubject);
     subjects.forEach((element) {
      if (element.name == NameSubject) {
        check = true;
      }
     });

     return check!;

  }
// to get all subject name from data base to show it in choose subject screen
  void getAllSubject(year, semister) {
    FirebaseFirestore.instance
        .collection("Academic year")
        .doc(year)
        .collection(semister)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (year == "First Year" && !firstYear.contains(element.get("name"))) {
          firstYear.add(element.get("name"));
        }
        if (year == "Second Year" &&
            !secondYear.contains(element.get("name"))) {
          secondYear.add(element.get("name"));
        }
        if (year == "Third Year" && !thirdYear.contains(element.get("name"))) {
          thirdYear.add(element.get("name"));
        }
        if (year == "Fourth Year" &&
            !fourthYear.contains(element.get("name"))) {
          fourthYear.add(element.get("name"));
        }
      });
      emit(GetAllSubject());
    });
  }
// to get if user pay or not to this week

  bool beSurePayment({required int index, required bool week}) {
    if (index == 0 && week == true) {
      return true;
    }
    if (index == 1 && week == true) {
      return true;
    }
    if (index == 2 && week == true) {
      return true;
    }
    if (index == 3 && week == true) {
      return true;
    }
    if (index == 4 && week == true) {
      return true;
    } else
      return false;
  }

  void getPhoto(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String week}) {
    FirebaseFirestore.instance
        .collection("Academic year")
        .doc(academicYear)
        .collection(semester)
        .doc(subjectName)
        .collection("Photo")
        .doc(week)
        .get()
        .then((value) {
      photo = Photo(
        linkPhoto: value.get("link"),
        description: value.get("description"),
      );
      emit(GetPhotoSuccessfully());
    }).catchError((onError) {
      log(onError.toString());
      emit(GetPhotoFailed());
    });
  }

  void getVideo(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String week}) {
    print("$academicYear $semester $subjectName $week");
    FirebaseFirestore.instance
        .collection("Academic year")
        .doc(academicYear)
        .collection(semester)
        .doc(subjectName)
        .collection("videos")
        .doc(week)
        .get()
        .then((value) {
      video = Video(
        linkVideo: value.get("link"),
        description: value.get("description"),
      );
      emit(GetVideoSuccessfully());
    }).catchError((onError) {
      log(onError.toString());
      emit(GetVideoFailed());
    });
  }

  void getPdf(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String week}) {
    FirebaseFirestore.instance
        .collection("Academic year")
        .doc(academicYear)
        .collection(semester)
        .doc(subjectName)
        .collection("Pdf")
        .doc(week)
        .get()
        .then((value) {
      pdf = Pdf(
        linkPdf: value.get("link"),
        description: value.get("description"),
      );
      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      log(onError.toString());
      emit(GetPdfFailed());
    });
  }

  void getWeekData(
      {required String academicYear,
      required String subjectName,
      required String week}) {
    getPhoto(
        academicYear: academicYear,
        semester: user!.semester!,
        subjectName: subjectName,
        week: week);
    getVideo(
        academicYear: academicYear,
        semester: user!.semester!,
        subjectName: subjectName,
        week: week);
    getPdf(
        academicYear: academicYear,
        semester: user!.semester!,
        subjectName: subjectName,
        week: week);
/*    print(video!.description);
    print(photo!.description);
    print(pdf!.description);*/
  }

  void changeLocale(BuildContext context, language) {
    context.setLocale(language);
    emit(ChangeLocale());
  }

  void readQrCode(String qrCode) {
    qrStar=qrCode;
    emit((BrCodeReading()));
  }
}
