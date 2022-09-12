import 'dart:developer';
import 'dart:io';
import 'package:afer/Extintion/extinition.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import '../model/lecture.dart';
import '../screens/week_details/lecture_screen.dart';
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
  UserModule user = UserModule();
  List<Widget> screens = [
    const SubjectsScreen(),
    MessageScreen(),
    MessageScreen(),
    Setting()
  ];

  // Home Layout Screen variables

  List<Widget> lectureScreen = [
    ShowLecture(),
    const ShowVideo(),
    ShowSummery(),
    ShowQuestion(),
  ];
  int currentIndex = 0;
  int indexRegisterScreen = 0;
  XFile? file;
  XFile? fileUpdate;
  String? profileUrl;

  void changeRegister(int newIndex) {
    indexRegisterScreen = newIndex;
    emit(ChangeRegisterScreen());
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
  List<Subject> secondYear = [];
  List<Subject> thirdYear = [];
  List<Subject> fourthYear = [];
  String academicYear = "First year";
  String semester = "First semester";
  bool isObscureSignIn = true;
  var signInFormKey = GlobalKey<FormState>();

  //Settings Screen variables
  List<Subject> firstYear = [];
  List<Subject> subjects = [];
  Video? video;
  Photo? photo;
  Pdf? pdf;
  bool videoLocked=false;
  bool photoLocked=false;
  bool pdfLocked=false;
  List<bool>locked=[];
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

  void takeImage(XFile? newFile) {
    file = newFile;
    uploadProfilePhoto();
    emit(TakeImageSignUp());
  }

  void updateImage(XFile? newFile) {
    fileUpdate = newFile;
    uploadProfilePhoto();
    emit(UpdateImage());
  }

  void createAccount(uid) {
    UserModule user = UserModule(
      uid: uid,
      firstName: nameController.text,
      secondName: lastNameController.text,
      email: emailController.text,
      phone: int.parse(phoneNumberController.text),
      premium: false,
      profileUrl: profileUrl,
      pass: passwordController.text,
      semester: "First semester",
      academicYear: academicYear,
    );
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

  void uploadProfilePhoto() {
    FirebaseStorage.instance
        .ref()
        .child('profilePhoto/${file!.path.substring(0, 10)}')
        .putFile(File(file!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileUrl = value;
      });
    });
  }

  void getInfo(uid) {
    FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) {
      user = UserModule.fromJson(value.data()!);
      // add subjects to list to use it in subject screen to show subjects to user and get all data of subject
      subjects.clear();
// this condition to check if data base info is correct or not
      if (!user.firstSubjects!.containsValue(null) &&
          user.firstSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["FirstSubjects"]));
      }
      if (!user.secondSubjects!.containsValue(null) &&
          user.secondSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["SecondSubjects"]));
      }
      if (!user.thirdSubjects!.containsValue(null) &&
          user.thirdSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["ThirdSubjects"]));
      }
      if (!user.fourthSubjects!.containsValue(null) &&
          user.fourthSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["FourthSubjects"]));
      }
      if (!user.fiftySubjects!.containsValue(null) &&
          user.fiftySubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["fiftySubjects"]));
      }
      if (!user.sixSubjects!.containsValue(null) &&
          user.sixSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["sixtySubjects"]));
      }
      if (!user.sevenSubjects!.containsValue(null) &&
          user.sevenSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.data()!["seventySubjects"]));
      }
      emit(GetUserInfoSuccess());
    }).catchError((error) {
      log(error.toString());
      emit(GetUserInfoFailed());
    });
  }

  void signUp(context) {
    print(" this is ${emailController.text}");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      print(value.user!.uid);
      createAccount(value.user!.uid);
      navigator(context: context, page: const SignScreen(), returnPage: false);
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
      navigator(context: context, page: const SignScreen(), returnPage: false);
      sherdprefrence.removedate(key: "token");
      emit(LogOut());
    });
  }

  void toggleRememberMe(value) {
    rememberMe = value;
    emit(ToggleRememberMe());
  }

  void ChooseSubject() {
    user = UserModule(
      uid: user.uid,
      profileUrl: user.profileUrl,
      firstName: user.firstName,
      secondName: user.secondName,
      email: user.email,
      phone: user.phone,
      premium: user.premium,
      firstSubjects: subjects[0].toJson(),
      secondSubjects: subjects.length >= 2 ? subjects[1].toJson() : {},
      thirdSubjects: subjects.length >= 3 ? subjects[2].toJson() : {},
      fourthSubjects: subjects.length >= 4 ? subjects[3].toJson() : {},
      fiftySubjects: subjects.length >= 5 ? subjects[4].toJson() : {},
      sixSubjects: subjects.length >= 6 ? subjects[5].toJson() : {},
      sevenSubjects: subjects.length >= 7 ? subjects[6].toJson() : {},
      semester: user.semester,
      pass: user.pass,
      academicYear: user.academicYear,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(sherdprefrence.getdate(key: "token"))
        .update(user.toJson())
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
      uid: user.uid,
      profileUrl: user.profileUrl,
      firstName: usernameController.text,
      secondName: username2Controller.text,
      email: user.email,
      phone: int.parse(userPhoneNumberController.text),
      firstSubjects: user.firstSubjects,
      secondSubjects: user.secondSubjects,
      thirdSubjects: user.thirdSubjects,
      fourthSubjects: user.fourthSubjects,
      fiftySubjects: user.fiftySubjects,
      sixSubjects: user.sixSubjects,
      sevenSubjects: user.sevenSubjects,
      premium: user.premium,
      pass: userPasswordController.text,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(sherdprefrence.getdate(key: "token"))
        .update(user.toJson())
        .then((value) {
      getInfo(sherdprefrence.getdate(key: "token"));
    }).catchError((onError) {});
  }

  void updatePassword() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: user.pass!)
        .then((value) {
      FirebaseAuth.instance.currentUser!
          .updatePassword(userPasswordController.text);
    });
  }

// to add new subject into map to get it from data base
  void MakeMapSubject(String Year, Subject subject, value, int index) {
    if (value == false) {
      subjects.remove(subjects[index]);
    } else {
      subjects.insert(subjects.length, subject);
    }
    emit(MakeMapSubjectState());
  }

  // to make check box true or false
  bool sureSubject(Subject subject) {
    bool? check = false;
    for (var element in subjects) {
      if (element.isEqutaple(subject)) {
        check = true;
      }
    }

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
      for (var element in value.docs) {
        if (year == "First Year" &&
            !firstYear
                .any((E) => E.isEqutaple(Subject.fromJson(element.data())))) {
          firstYear.add(Subject.fromJson(element.data()));
        }
        if (year == "Second Year" &&
            !secondYear
                .any((E) => E.isEqutaple(Subject.fromJson(element.data())))) {
          secondYear.add(Subject.fromJson(element.data()));
        }
        if (year == "Third Year" &&
            !thirdYear
                .any((E) => E.isEqutaple(Subject.fromJson(element.data())))) {
          thirdYear.add(Subject.fromJson(element.data()));
        }
        if (year == "Fourth Year" &&
            !fourthYear
                .any((E) => E.isEqutaple(Subject.fromJson(element.data())))) {
          fourthYear.add(Subject.fromJson(element.data()));
          print(element.data());
        }
      }
      emit(GetAllSubject());
    });
  }

  Future<List<Lecture>> getMyLectures({required Subject subject}) async {
    List<Lecture> lectures = [];
    await FirebaseFirestore.instance
        .collection("Academic year")
        .doc(subject.academicYear)
        .collection("First semester")
        .doc(subject.name)
        .collection("Lecture")
        .get()
        .then((value) {
      print(value.docs.length);
      for (var element in value.docs) {
        lectures.add(Lecture.fromJson(element.data()));
      }
    }).catchError((onError) {
      print(onError.toString());
    });
    return lectures;
  }

  void getPhoto(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName}) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'photo')
        .get()
        .then((value) {
      photo = Photo.fromJson(value.docs.last.data()!);
      photoLocked=value.docs.last.get("isPaid");
      emit(GetPhotoSuccessfully());
    }).catchError((onError) {
      log(onError.toString());
      photo = Photo(
          id: null,
          isPaid: null,
          description: null,
          linkPhoto: null,
          point: null);
      emit(GetPhotoFailed());
    });
  }

  void getVideo(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName}) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'videos')
        .get()
        .then((value) {
      video = Video.fromJson(value.docs.last.data()!);
    videoLocked=value.docs.last.get("isPaid");
      emit(GetVideoSuccessfully());
    }).catchError((onError) {
      video = Video(
          id: null,
          isPaid: null,
          description: null,
          linkVideo: null,
          point: null);
      log(onError.toString());
      emit(GetVideoFailed());
    });
  }

  void getPdf(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName}) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'pdf')
        .get()
        .then((value) {
      pdf = Pdf.fromJson(value.docs.last.data()!);
      pdfLocked=value.docs.last.get("isPaid");
      locked=[pdfLocked,videoLocked,photoLocked,pdfLocked];

      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      log(onError.toString());
      pdf = Pdf(
          id: null,
          isPaid: null,
          description: null,
          linkPdf: null,
          point: null);
      emit(GetPdfFailed());
    });
  }

  void getLectureData(
      {required String academicYear,
      required String subjectName,
      required String lectureName,
      required BuildContext context}) {
    weekTemplateCurrentIndex = 0;
    getPhoto(
        academicYear: academicYear,
        semester: user.semester!,
        subjectName: subjectName,
        lectureName: lectureName);
    getVideo(
        academicYear: academicYear,
        semester: user.semester!,
        subjectName: subjectName,
        lectureName: lectureName);
    getPdf(
        academicYear: academicYear,
        semester: user.semester!,
        subjectName: subjectName,
        lectureName: lectureName);
print(locked);
    navigator(context: context, returnPage: true, page: LectureScreen());
  }

  void changeLocale(BuildContext context, language) {
    context.setLocale(language);
    emit(ChangeLocale());
  }

  void readQrCode(String qrCode) {
    qrStar = qrCode;
    emit((BrCodeReading()));
  }

  CollectionReference _dataReference(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName,
      required String type}) {
    return FirebaseFirestore.instance
        .collection("Academic year")
        .doc(academicYear)
        .collection(semester)
        .doc(subjectName)
        .collection("Lecture")
        .doc(lectureName)
        .collection(type);
  }

}
