import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:states/SM/states.dart';
import 'package:states/views/Home.dart';
import 'package:states/views/Lands.dart';
import 'package:states/views/Mylands.dart';
import 'package:states/views/profile.dart';

import '../network/cache_helper.dart';

class StateCubit extends Cubit<StatesStates> {
  StateCubit() : super(StatesInitialState());
  static StateCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void Mode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StatesModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(StatesModeState());
      });
    }
  }

  int currentIndex = 0;
  List<Widget> pages = [
    const Lands(),
    const MyLands(),
    const Profile(),
  ];
  void changeNavBar(int index) {
    currentIndex = index;
    emit(StatesNavigationState());
  }

  List landsData = [];
  Future<void> getLands() async {
    landsData = [];
    emit(GetLandsLoadingState());
    CollectionReference lands = FirebaseFirestore.instance.collection('lands');
    return await lands.get().then((value) {
      value.docs.forEach(
        (element) {
          landsData.add(element.data());
        },
      );
      print(landsData);
      emit(GetLandsSuccessState());
    }).catchError((error) {
      emit(GetLandsErrorState());
      print("error");
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState("The password provided is too weak."));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState("The account already exists for that email."));
        print('The account already exists for that email.');
      }
    }
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set({"email": email, "name": name, "phone": phone, "uId": uId}).then(
            (value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void login({email, password}) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(LoginSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('No user found for that email.'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('Wrong password provided for that user.'));
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().catchError((error, stackTrace) {
        print(error);
        print(StackTrace.current);
      });

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          "email": value.user!.email,
          "name": value.user!.displayName,
          "phone":  value.user!.phoneNumber,
          "uId": value.user!.uid,
        });

        emit(CreateUserSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString() + "errrrrrrrrrrrr");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    emit(SignOutSuccess());
  }

  bool isChecked = false;
  void changeCheck() {
    isChecked = !isChecked;
    emit(IsCheckedState());
  }

  bool isVisible = false;
  void Visible() {
    isVisible = !isVisible;
    emit(IsVisibleState());
  }

  Map<String, dynamic>? userData = {};
  void getUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        userData = value.data();
        emit(GetUserDataSuccess());
        print("123456");
        print(userData);
      });
    }
  }

  List<XFile> LandImages = [];
  List LandImagesPath = [];
  var pickerLand = ImagePicker();

  Future<void> getLandImageImage() async {
    LandImages = [];
    LandImagesPath = [];

    emit(PickImagesLoadingState());
    final pickedFiles =
        await pickerLand.pickMultiImage(imageQuality: 35).then((value) {
      LandImages = value!;
      value.forEach((element) {
        LandImagesPath.add(element.path);
      });
     
      emit(PickImagesSuccessState());
    }).catchError((error) {
      emit(PickImagesErrorState());
    });
  }

  List imagesUrls = [];

  int counter = 0;
  Future<void> uploadimage({
    XFile? element,
    String? title,
    String? place,
    String? price,
    String? space,
    String? about,
    String? name,
    String? phone,
  }) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(element!.path).pathSegments.last}");
    UploadTask uploadTask = reference.putFile(File(element.path));
    await uploadTask.whenComplete(() => {
          reference.getDownloadURL().then((value) {
            imagesUrls.add(value);
            print("${counter} = URL:  ${value}");
            counter += 1;
            if (counter == LandImages.length) {
              counter = 0;
              LandImages = [];
              print("finished......................");
              print(imagesUrls);
              addLand(
                  title: title,
                  place: place,
                  price: price,
                  space: space,
                  name: name,
                  phone: phone,
                  about: about);
              emit(AddLandSuccessState());
            }
          })
        });
  }

  Future<void> uploadImages({
    String? title,
    String? place,
    String? price,
    String? space,
    String? about,
    String? name,
    String? phone,
  }) async {
    emit(AddLandLoadingState());

    for (int i = 0; i < LandImages.length; i++) {
      var imgUrl = uploadimage(
          element: LandImages[i],
          title: title,
          place: place,
          price: price,
          space: space,
          name: name,
          phone: phone,
          about: about);
    }
  }

  void addLand({
    String? title,
    String? place,
    String? price,
    String? space,
    String? about,
    String? name,
    String? phone,
    
  }) async {
    emit(AddLandLoadingState());
    CollectionReference lands = FirebaseFirestore.instance.collection('lands');
   var docId= lands.doc().id;

    return await lands.doc(docId).set(
      {
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "title": title,
        "name": name,
        "phone": phone,
        "price": price,
        "place": place,
        "space": space,
        "about": about,
        "date": DateTime.now().toString(),
        "images": imagesUrls,
        "id":docId,
        
      },
    ).then((value) async {
      print("data added");
      LandImages = [];
      LandImagesPath = [];
      emit(AddLandSuccessState());
    }).catchError((error) {
      print("error");
      emit(AddLandErrorState());
    });
  }

  List filterData = [];
  bool isFilterd = false;
  void filterPlace({String? value, String? key}) {
    filterData = landsData.where((element) {
      return element[key] == value.toString();
    }).toList();
    isFilterd = true;
    print("aaaa");
    emit(GetLandsSuccessState());
  }

  void filterPriceAndSpace({String? value, String? key}) {
    filterData = landsData.where((element) {
      return int.parse(element[key]) < int.parse(value.toString());
    }).toList();
    isFilterd = true;
    print("aaaa");
    emit(GetLandsSuccessState());
  }

  void filterPriceAndSpaceMore({String? value, String? key}) {
    filterData = landsData.where((element) {
      return int.parse(element[key]) >= int.parse(value.toString());
    }).toList();
    isFilterd = true;
    print("aaaa");
    emit(GetLandsSuccessState());
  }

  void removeFilter() {
    isFilterd = false;
    emit(GetLandsSuccessState());
  }

  Future resetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      emit(ResetPasswordSuccessState());
      return "";
    }).catchError((e) {
      emit(ResetPasswordErrorState());

      print(e);
    });
  }

  void update({name, email, phone}) async {
    emit(UpdateUserLoadingState());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "email": email,
      "name": name,
      "phone": phone,
      "uid": FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError((e) {
      emit(UpdateUserErrorState());
    });
  }
  List myLands = [];
  void getMyLands()async{
    myLands = landsData.where((element) {
      return  element["userId"] == FirebaseAuth.instance.currentUser!.uid ;
    }).toList();
            emit(GetMyLandsSuccessState());

   
  }

  void removeLand(index ,id)async{
  await  FirebaseFirestore.instance.collection("lands").doc(id).delete().then((value) {
            landsData.removeWhere((element) {
              return  element["id"] == id;
            },);
             myLands.removeWhere((element) {
            return  element["id"] == id;
            });
            emit(RemoveLandSuccess());
  });
  }
}
