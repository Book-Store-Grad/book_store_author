import 'dart:io';
import 'package:book_store_author/Const/API/Url.dart';
import 'package:book_store_author/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helper/dio_helper/dio_helper.dart';
import '../../../helper/shared_prefrences/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String gender = 'male';

  void updateProfile({
    required String name,
  }) {
    emit(ProfileLoadingState());
    DioHelper.putData(
        url: ApiUrl.profile,
        token: CacheHelper.getData(key: "token"),
        data: {"name": name, "gender": gender}).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        print("Profile Updated successfully !");
      } else {
        print("Profile Edit Error !");
      }
      emit(ProfileSuccessState());
    }).catchError((e) {
      emit(ProfileErrorState());
    });
  }

  Profile? profile;

  void getProfile() {
    {
      emit(ProfileLoadingState());
      DioHelper.getData(
          url: ApiUrl.profile, token: CacheHelper.getData(key: "token")).then((
          value) {
        print(value.data);
        if (value.statusCode == 200) {
          profile = Profile.fromJson(value.data);
          nameController.text = profile!.content!.customer!.uName!;
          emailController.text = profile!.content!.customer!.uEmail!;
          gender = profile!.content!.customer!.uGender!;
          print("Get Profile successfully !");
        } else {
          print("Get Profile Error !");
        }
        emit(ProfileSuccessState());
      }).catchError((e) {
        emit(ProfileErrorState());
      });
    }
  }
  File? image;

  chooseProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(ChooseImageState());
  }
  void updateProfileImage() async {
    emit(UpdateProfileImageLoadingState());
    DioHelper.postData(
        containImage: true,
        url: ApiUrl.profileImage,
        token: CacheHelper.getData(key: "token"),
        data: {
          "image": await MultipartFile.fromFile(image!.path,
              filename: image!
                  .path
                  .split('/')
                  .last, contentType: MediaType('image', 'jpg')),
        }).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        print('Profile uploaded Successfully');
      }
      emit(UpdateProfileImageSuccessState());
    }).catchError((e) {
      emit(UpdateProfileImageErrorState());
    });
  }
}
