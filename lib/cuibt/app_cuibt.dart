import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:afer/Extintion/extinition.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/model/subject.dart';
import 'package:afer/screens/auth/un_normal_auth.dart';
import 'package:afer/screens/week_details/feedback_screen.dart';
import 'package:afer/screens/week_details/show_alerts.dart';
import 'package:afer/screens/week_details/show_lecture.dart';
import 'package:afer/screens/week_details/show_question.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:share_plus/share_plus.dart';
import '../model/exam.dart';
import '../model/lecture.dart';

import '../model/notes.dart';
import '../screens/week_details/show_video.dart';
import '../model/user_model.dart';
import '../model/pdf.dart';
import '../model/photo.dart';
import '../model/video.dart';
import '../screens/message_screen.dart';
import '../screens/auth/auth_home.dart';
import '../screens/home_loyout.dart';
import '../screens/settings_screen.dart';
import '../screens/subjects_screen.dart';
import 'package:afer/SheredPreferance/shered_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AferInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  // Home Layout Screen variables
  UserModule user = UserModule();
  List<Widget> screens = [
    const SubjectsScreen(),
    const MessageScreen(),
    const MessageScreen(),
    const Setting()
  ];
  final TextEditingController feedBackController = TextEditingController();
  String subjectNotes = "";
  List<Notes> studentNotes = [];
  String uidNote = "";
  String subjectName = "";
  String lectureName = "";
  bool isSend = false;

  // Home Layout Screen variables
  int selectedPos = 0;
  File? fileer;
  late CircularBottomNavigationController navigationController;
  List<Widget> lectureScreen = [
    const ShowLecture(),
    const ShowVideo(),
    const ShowQuestion(),
    const ShowAlerts(),
    const FeedBackScreen(),
  ];
  int currentIndex = 0;
  int indexRegisterScreen = 0;
  XFile? file;
  File? vidoe;
  XFile? fileUpdate;
  String? profileUrl;

  void changeRegister(int newIndex) {
    indexRegisterScreen = newIndex;
    emit(ChangeRegisterScreen());
  }

  var qrStar = "let's Scan it";

  // Home Layout Screen Functions
  void weekTemplateChangeIndex(int index) {
    if (weekTemplateCurrentIndex != index) {
      weekTemplateCurrentIndex = index;
      emit(WeekTemplateChangeIndex());
    }
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
  var signUpFormKey = GlobalKey<FormState>();
  int points = 0;

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
  String semester ="First semester";
  bool isObscureSignIn = true;
  var signInFormKey = GlobalKey<FormState>();
  Notes notes = Notes();

  //Settings Screen variables
  List<Subject> firstYear = [];
  List<Subject> subjects = [];
  Video video = Video(isPaid: false);
  List<Photo> photo = [];
  Pdf pdf = Pdf();
  List<Question> questions = [];
  Uint8List bytes = Uint8List(0);
  List<bool> locked = [false, false, true, true, true];
  bool isObscureEditInfo = true;

  //Settings Screen Functions

  void changeObscure() {
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
    selectedPos = index;
    navigationController.value = 0;
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
    file = newFile;
    uploadProfilePhoto();
    emit(UpdateImage());
  }
void changeSemester(semestervalue){
  semester = semestervalue;
  emit(ChangeSemester());
}
  Future<void> createAccount(uid) async {
    UserModule user = UserModule(
      uid: uid,
      firstName: nameController.text,
      secondName: lastNameController.text,
      email: emailController.text,
      phone: int.parse(phoneNumberController.text),
      premium: false,
      profileUrl: profileUrl,
      pass: passwordController.text,
      semester: semester,
      academicYear: academicYear,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(user.toJson())
        .then((value) {
      getInfo(uid);
      emit(CreateAccountSuccess());
    }).catchError((error) {
      emit(CreateAccountFailed());
    });
  }

  void uploadProfilePhoto() {
    FirebaseStorage.instance
        .ref()
        .child('profilePhoto/${user.uid}')
        .putFile(File(file!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileUrl = value;
      });
    });
  }

  void updateProfilePhoto() {
    FirebaseStorage.instance
        .ref()
        .child('profilePhoto/${user.uid}')
        .putFile(File(file!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileUrl = value;
      });
    });
  }

  Future<void> getInfo(uid) async {
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
        subjects.add(Subject.fromJson(value.get("SecondSubjects")));
      }
      if (!user.thirdSubjects!.containsValue(null) &&
          user.thirdSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.get("thirdSubjects")));
      }
      if (!user.fourthSubjects!.containsValue(null) &&
          user.fourthSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.get("fourthSubjects")));
      }
      if (!user.fiftySubjects!.containsValue(null) &&
          user.fiftySubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.get("fiftySubjects")));
      }
      if (!user.sixSubjects!.containsValue(null) &&
          user.sixSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.get("sixSubjects")));
      }
      if (!user.sevenSubjects!.containsValue(null) &&
          user.sevenSubjects!.isNotEmpty) {
        subjects.add(Subject.fromJson(value.get("sevenSubjects")));
      }

      emit(GetUserInfoSuccess());
    }).catchError((error) {
      user = UserModule();
      emit(GetUserInfoFailed());
    });
  }

  void signUp(context) async {
    //print(" this is ${emailController.text}");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      createAccount(value.user!.uid);
      navigator(
        context: context,
        page: const AuthScreen(),
        returnPage: false,
      );
    }).catchError((error) {
      MotionToast.error(
        description: Text(error.toString()),
        title: Text(LocaleKeys.error.tr()),
      ).show(context);

      emit(CreateAccountFailed());
    });
  }

  String codeSent = "";

  void verifyPhoneNumber({
    required BuildContext context,
    required String phone,
  }) async {
    int? forceResendingToken;
    await FirebaseAuth.instance.verifyPhoneNumber(
      forceResendingToken: forceResendingToken,
        phoneNumber: "+2$phone",
        verificationCompleted: (credential) {
        },
        verificationFailed: (verificationFailed) {
          MotionToast.error(
            description: Text(verificationFailed.message.toString()),
            title: const Text(LocaleKeys.tryAgain),
          ).show(context);
        },
        codeSent: (verificationId, resendingToken) {
          codeSent = verificationId;
          forceResendingToken = resendingToken;
          },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
          codeSent = codeAutoRetrievalTimeout;
        },
        timeout: const Duration(seconds: 60));
  }

  Future<void> signInWithPhone(BuildContext context, String otp,String phoneNumber,) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: AppCubit.get(context).codeSent, smsCode: otp,))
          .then((value) {
if(value.additionalUserInfo!.isNewUser){
  navigator(
    context: context,
    page:  UnNormalSignUp(isGoogleSignIn: false, phone: phoneNumber, uid: value.user!.uid),
    returnPage: false,
  );
}
else{
  Sherdprefrence.setdate(key: "token", value: value.user!.uid);
  getInfo(value.user!.uid).then((value) =>   navigator(page: const HomeLayout(),returnPage: false,context: context));
}
      });
    } catch (e) {
      MotionToast.error(
        description: Text(e.toString()),
        title: const Text(LocaleKeys.tryAgain),
      ).show(context);
    }
  }
  Future<void> signInWithGoogle(BuildContext context)async{
    try{final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount ;
    final googleUser=await googleSignIn.signIn();
    if(googleUser!=null){
      googleSignInAccount=googleUser;
      final googleAuth=await googleSignInAccount.authentication;
      final credential=GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if(value.additionalUserInfo!.isNewUser){
          navigator(page:  UnNormalSignUp(isGoogleSignIn: true, phone: "", uid: value.user!.uid),returnPage: false,context: context);
        }else{
          Sherdprefrence.setdate(key: "token", value: value.user!.uid);
          getInfo(value.user!.uid).then((value) =>   navigator(page: const HomeLayout(),returnPage: false,context: context));
        }

      });
    }}
        catch(e){
          MotionToast.error(
            description: Text(e.toString()),
            title: const Text(LocaleKeys.tryAgain),
          ).show(context);

        }

  }

  void signIn(context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailSignInController.text,
            password: passwordSignInController.text)
        .then((value) {
      getInfo(value.user!.uid);
      if (rememberMe) {
        Sherdprefrence.setdate(key: "token", value: value.user!.uid);
      }
      navigator(context: context, page: const HomeLayout(), returnPage: false);
    }).catchError((error) {
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
      navigator(context: context, page: const AuthScreen(), returnPage: false);
      Sherdprefrence.removedate(key: "token");
      emit(LogOut());
    });
  }

  void toggleRememberMe(value) {
    rememberMe = value;
    emit(ToggleRememberMe());
  }

  void chooseSubject() {
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
      points: user.points,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(Sherdprefrence.getdate(key: "token"))
        .update(user.toJson())
        .then((value) {
      getInfo(Sherdprefrence.getdate(key: "token"));
    }).catchError((onError) {});
  }

  void updateProfile(String oldPass) {
    updatePassword(oldPass);
    user = UserModule(
      uid: user.uid,
      profileUrl: profileUrl ?? user.profileUrl,
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
      pass: userConfirmPasswordController.text,
      points: user.points,
      semester: user.semester,
      academicYear: user.academicYear,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(Sherdprefrence.getdate(key: "token"))
        .update(user.toJson())
        .then((value) {
      getInfo(Sherdprefrence.getdate(key: "token"));
    }).catchError((onError) {});
  }

  void updatePassword(String oldPass) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: oldPass)
        .then((value) {
      FirebaseAuth.instance.currentUser!
          .updatePassword(userConfirmPasswordController.text);
    }).catchError((onError) {
      MotionToast.error(
        description: Text(onError.toString()),
        title: Text(LocaleKeys.error.tr()),
      );
    });
  }

// to add new subject into map to get it from data base
  void addSubject(String year, Subject subject, value, int index) {
    if (value == false) {
      var itemIndex =
          subjects.indexWhere((element) => element.isEqutaple(subject));
      subjects.removeAt(itemIndex);
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
      //print(value.docs.length);
      for (var element in value.docs) {
        lectures.add(Lecture.fromJson(element.data()));
      }
    }).catchError((onError) {
      // print(onError.toString());
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
        .then((value) async {
      photo = List.generate(value.docs.length,
          (index) => Photo.fromJson(value.docs[index].data()!));

      emit(GetPhotoSuccessfully());
    }).catchError((onError) {
      photo.clear();
      emit(GetPhotoFailed());
    });
  }

  void getVideo(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName}) async {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'videos')
        .get()
        .then((value) async {
      video = Video.fromJson(value.docs.last.data()!);
      getIfVideoPayed(uidVideo: video.id!, isPayed: video.isPaid ?? false);
      await DefaultCacheManager()
          .getFileFromCache(video.linkVideo!)
          .then((value) async {
        vidoe = await DefaultCacheManager()
            .getFileFromCache(video.linkVideo!)
            .then((value) => value!.file);
      }).catchError((onError) {
        DefaultCacheManager()
            .downloadFile(video.linkVideo!)
            .then((value) async {
          DefaultCacheManager()
              .putFile(video.linkVideo!, await value.file.readAsBytes(),
                  key: video.linkVideo!,
                  eTag: video.linkVideo!,
                  maxAge: const Duration(days: 120))
              .then((value) async {
            vidoe = await DefaultCacheManager()
                .getFileFromCache(video.linkVideo!, ignoreMemCache: true)
                .then((value) => value!.file);
          });
          emit(GetVideoSuccessfully());
        });
      });

      emit(GetVideoSuccessfully());
    }).catchError((onError) {
      video = Video(
          id: null,
          isPaid: null,
          description: null,
          linkVideo: null,
          point: null);
      locked[1] = true;
      emit(GetVideoFailed());
    });
  }

  void getPdf(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName,
      required BuildContext context}) {
    bytes = Uint8List(0);
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'pdf')
        .get()
        .then((value) async {
      var pdfId = value.docs.last.id;
      pdf = Pdf.fromJson(value.docs.last.data()!);
      getIfPdfPayed(
          uidPdf: pdfId, isPayed: value.docs.last.get("isPaid") ?? false);
      await DefaultCacheManager().getFileFromCache(pdfId).then((pdf) async {
        bytes = await DefaultCacheManager()
            .getFileFromCache(pdfId)
            .then((value) => value!.file.readAsBytes());
      }).catchError((onError) {
        DefaultCacheManager()
            .downloadFile(value.docs.last.get("link"))
            .then((pdf) async {
          DefaultCacheManager()
              .putFile(
                  value.docs.last.get("link"), await pdf.file.readAsBytes(),
                  key: pdfId, eTag: pdfId, maxAge: const Duration(days: 120))
              .then((pdf) async {
            bytes = await DefaultCacheManager()
                .getFileFromCache(pdfId)
                .then((value) => value!.file.readAsBytes());
          });
        });
      });
      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      pdf = Pdf(
          id: null,
          isPaid: null,
          description: null,
          linkPdf: null,
          point: null);
      locked[2] = true;
      emit(GetPdfFailed());
    });
  }

  void getQuestion(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String lectureName}) {
    questions.clear();
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'Question')
        .get()
        .then((value) {
      questions.addAll(value.docs.map((e) => Question.fromJson(e.data()!)));
    });
  }

  void uploadNotes(String note) {
    notes = Notes(
      date: DateFormat.yMMMd("en").format(DateTime.now()),
      notes: note,
      uid: Random.secure().nextInt(1000000000).toString(),
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("Notes")
        .doc(subjectName)
        .collection(lectureName)
        .doc(notes.uid)
        .set(notes.toMap())
        .then((value) {
      emit(UploadNotesSuccessfully());
    });
  }

  Future<void> getLectureData({
    required String academicYear,
    required String subjectName,
    required String lectureName,
    required BuildContext context,
  }) async {
    locked = [false, false, true, true, true];
    weekTemplateCurrentIndex = 0;
    pdf = Pdf(point: "0", linkPdf: '', description: '', id: '', isPaid: false);
    video = Video(
        point: "0", linkVideo: '', description: '', id: '', isPaid: false);
    photo.clear();
    studentNotes.clear();
    getPdf(
        academicYear: academicYear,
        semester: user.semester!,
        subjectName: subjectName,
        lectureName: lectureName,
        context: context);
    getQuestion(
        academicYear: academicYear,
        semester: user.semester!,
        subjectName: subjectName,
        lectureName: lectureName);
    getTeacherNotes(
      academicYear: academicYear,
      semester: user.semester!,
      subjectName: subjectName,
      lectureName: lectureName,
    );

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
    getNote();
//Navigator.pop(context);
    weekTemplateCurrentIndex = locked.contains(true) ? locked.indexOf(true) : 4;
  }

  void changeLocale(BuildContext context, language) {
    context.setLocale(language);
    emit(ChangeLocale());
  }

  void readQrCode(String qrCode, context) async {
    qrStar = qrCode;
    await FirebaseFirestore.instance
        .collection("qrcode")
        .doc(qrCode)
        .get()
        .then((value) async {
      if (value.exists) {
        if (qrStar.split(" ").first == "Prm") {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .update({"premium": true});
          FirebaseFirestore.instance
              .collection("qrcode")
              .doc("premium")
              .get()
              .then((value) async {
            var premium = value.data()!["premium"] ?? 0;
            await FirebaseFirestore.instance
                .collection("qrcode")
                .doc("premium")
                .update({"premium": (premium + 1)});
          });
          await FirebaseFirestore.instance
              .collection("qrcode")
              .doc(qrCode)
              .delete();
          MotionToast.success(
                  description: Text(LocaleKeys.yourNowPremium.tr()),
                  title: Text(LocaleKeys.congratulations.tr()))
              .show(context);
        } else {
          pointsIncrease(point: int.tryParse(qrCode.split(" ").last) ?? 0);
          FirebaseFirestore.instance
              .collection("qrcode")
              .doc("money")
              .get()
              .then((value) async {
            var money = int.tryParse(value.data()!["money"]) ?? 0;
            await FirebaseFirestore.instance
                .collection("qrcode")
                .doc("money")
                .update({
              "money":
                  (money + int.tryParse(qrCode.split(" ").last)!).toString()
            });
          });
          await FirebaseFirestore.instance
              .collection("qrcode")
              .doc(qrCode)
              .delete();
        }
      } else {
        MotionToast.warning(
          description: Text(
            LocaleKeys.errorQr.tr(),
          ),
          title: Text(
            LocaleKeys.qrNotFound.tr(),
          ),
        ).show(context);
      }
    }).catchError((onError) {
      MotionToast.warning(
        description: Text(
          LocaleKeys.errorQr.tr(),
        ),
        title: Text(LocaleKeys.qrNotFound.tr()),
      ).show(context);
    });
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

  Future<bool> getIfVideoPayed(
      {required String uidVideo, required bool isPayed}) async {
    return await getSecureReference(
            type: "video", uidItem: uidVideo, isPayed: isPayed)
        .then((value) {
      locked[1] = value;
      return value;
    }).catchError((onError) {
      locked[1] = true;
      return true;
    });
  }

  Future<bool> getIfPdfPayed(
      {required String uidPdf, required bool isPayed}) async {
    return await getSecureReference(
            type: "Pdf", uidItem: uidPdf, isPayed: isPayed)
        .then((value) {
      locked[0] = value;
      return value;
    }).catchError((onError) {
      locked[0] = true;
      return true;
    });
  }

  Future<bool> getSecureReference(
      {required String uidItem,
      required String type,
      bool isPayed = false}) async {
    return await FirebaseFirestore.instance
        .collection("secure")
        .doc(type)
        .collection(uidItem)
        .doc(user.uid)
        .get()
        .then((value) {
      if (isPayed) {
        if (value.exists) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    });
  }

  DocumentReference secureDataReference(
      {required String uidItem, required String type}) {
    return FirebaseFirestore.instance
        .collection("secure")
        .doc(type)
        .collection(uidItem)
        .doc(user.uid!);
  }

  void secureDataVideo(context, {videoId}) async {
    losePoints(point: int.tryParse(video.point!) ?? 0).then((value) {
      if (value) {
        secureDataReference(uidItem: videoId, type: "video")
            .set({"uid": user.uid!, "videoId": videoId}).then((value) {
          getIfVideoPayed(uidVideo: videoId, isPayed: video.isPaid!);
          getInfo(user.uid!);
        }).catchError((onError) {
          //print(onError);
          MotionToast.error(
            description: Text(LocaleKeys.errorWhilePaying.tr()),
            title: Text(LocaleKeys.error.tr()),
          ).show(context);
        });
      }
    }).catchError((onError) {
      //print(onError);
      MotionToast.error(
        description: Text(LocaleKeys.errorWhilePaying.tr()),
        title: Text(LocaleKeys.error.tr()),
      ).show(context);
    });
  }

  void secureDataPdf(context, {pdfId}) async {
    losePoints(point: int.tryParse(pdf.point!) ?? 0).then((value) {
      if (value) {
        secureDataReference(uidItem: pdfId, type: "Pdf")
            .set({"uid": user.uid!, "pdfId": pdfId}).then((value) {
          getIfPdfPayed(uidPdf: pdfId, isPayed: pdf.isPaid!);
          getInfo(user.uid!);
        }).catchError((onError) {
          MotionToast.error(
            description: Text(LocaleKeys.errorWhilePaying.tr()),
            title: Text(LocaleKeys.error.tr()),
          ).show(context);
        });
      }
    });
  }

  void secureDataPhoto({photoId}) {
    secureDataReference(uidItem: photoId, type: "photo")
        .set({"uid": user.uid, "photoId": photoId}).then((value) {
      losePoints(point: int.tryParse(pdf.point!) ?? 0);
      emit(SecureDataSuccessfully());
    }).catchError((onError) {
      emit(SecureDataFailed());
    });
  }

  void secureDataExam({examId}) {
    secureDataReference(uidItem: examId, type: "exam")
        .set({"uid": user.uid, "examId": examId}).then((value) {
      losePoints(point: int.parse(video.point!));
      emit(SecureDataSuccessfully());
    }).catchError((onError) {
      emit(SecureDataFailed());
    });
  }

  Future<bool> losePoints({required int point}) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .update({"points": (int.parse(user.points!) - point).toString()})
        .then((value) => Future.value(true))
        .catchError((onError) => Future.value(false));
  }

  void pointsIncrease({required int point}) {
    //print("this is point $point");
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .update({"points": (int.parse(user.points!) + point).toString()})
        .then((value) => emit(LosePointsSuccessfully()))
        .catchError((onError) => emit(LosePointsFailed()));
    getInfo(user.uid!);
  }

  void secure({required int index, required context}) {
    if (getPoint(index) < int.parse(user.points!)) {
      if (index == 0) {
        secureDataPdf(context, pdfId: pdf.id!);
      }
      if (index == 1) {
        secureDataVideo(context, videoId: video.id!);
      }
      getAllSucre();
      getInfo(user.uid!);
    } else {
      //print("you don't have enough points");
      MotionToast.error(
        description: Text(LocaleKeys.notEnoughPoints.tr()),
        title: Text(LocaleKeys.errorWhilePaying.tr()),
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
    }
  }

  int getPoint(index) {
    if (index == 0) {
      return int.tryParse(pdf.point!) ?? 0;
    }
    if (index == 1) {
      return int.tryParse(video.point!) ?? 0;
    } else {
      return 0;
    }
  }

  Future<bool> getIfPayed(index) async {
    if (index == 0) {
      return pdf.isPaid ?? false;
    }
    if (index == 1) {
      return video.isPaid ?? false;
    } else {
      return false;
    }
  }

  Future<void> getAllSucre() async {
    getIfPdfPayed(uidPdf: pdf.id!, isPayed: pdf.isPaid!);
    if (video.id != null) {
      getIfVideoPayed(uidVideo: video.id!, isPayed: video.isPaid!);
    }
    emit(GetIsLocked());
  }

  bool showImageUnderVideo = false;

  void showImageVideo() {
    showImageUnderVideo = !showImageUnderVideo;
    emit(ShowImageUnderVideo());
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Column(children: [
          const CircularProgressIndicator(color: Colors.blue),
          const SizedBox(
            height: 10,
          ),
          Text(
            LocaleKeys.loading.tr(),
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.blue),
          )
        ]),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getTeacherNotes({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String lectureName,
  }) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            lectureName: lectureName,
            type: 'notes')
        .get()
        .then((value) async {
      subjectNotes = value.docs.last.get("notes");
      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      emit(GetPdfFailed());
    });
  }

  void getNote() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("Notes")
        .doc(subjectName)
        .collection(lectureName)
        .get()
        .then((value) {
      studentNotes = List.generate(value.docs.length,
          (index) => Notes.fromJson(value.docs[index].data()));
      emit(GetStudentNotesSuccessfully());
    }).catchError((onError) {
      emit(GetStudentNotesFailed());
    });
  }

  void uploadOrUpdateNotes(note) {
    if (uidNote.isEmpty) {
      uploadNotes(note);
    }
    if (uidNote.isNotEmpty) {
      updateNotes(note);
    }
  }

  void updateNotes(String note) {
    notes = Notes(
        date: DateFormat.yMMMd("en").format(DateTime.now()),
        notes: note,
        uid: uidNote);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("Notes")
        .doc(subjectName)
        .collection(lectureName)
        .doc(notes.uid)
        .update(notes.toMap())
        .then((value) {
      emit(UploadNotesSuccessfully());
    });
  }

  void toggleNotesShow(bool isEdit, String uid) {
    if (isEdit) {
      uidNote = uid;
      studentNotes.clear();
    } else {
      uidNote = "";
      studentNotes.clear();
    }
    emit(ToggleNotesShow());
  }

  void forgetPassword(String email, context) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      isSend = true;
      emailSignInController.text = "";

      emit(ForgetPasswordSuccessfully());
    }).catchError((onError) {
      MotionToast.error(
        title: Text(LocaleKeys.error.tr()),
        description: Text(onError.toString()),
      ).show(context);
      emit(ForgetPasswordFailed());
    });
  }

  void changeIndexTap(index) {
    weekTemplateCurrentIndex = 2;
    locked[index] = false;
    emit(ChangeIndexTap());
  }

  void shareApp() {
    Share.share(
        'https://play.google.com/store/apps/details?id=wai.waidevloper.afer',
        subject: 'Afer');
  }
}
