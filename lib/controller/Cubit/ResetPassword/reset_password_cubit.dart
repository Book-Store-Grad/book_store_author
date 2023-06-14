import 'package:bloc/bloc.dart';
import 'package:book_store_author/Const/API/Url.dart';
import 'package:book_store_author/helper/dio_helper/dio_helper.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/view/Screens/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  void resetpasword({required String password}) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
        url: ApiUrl.resetPassword,
        isJsonContentType: true,
        data: {
          "code": CacheHelper.getData(key: "code"),
          "password": password
        }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        Get.to(() => const Login());
        Get.snackbar("Success", "",
            maxWidth: 400,
            messageText: const Text(
              "Password Changed Successfully !",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 30,
            ),
            margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
      } else {
        Get.snackbar("Error", "",
            maxWidth: 400,
            messageText: const Text(
              "Please try again !",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: const Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
            margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
      }
      emit(ResetPasswordSuccessState());
    }).catchError((e) {
      print("this:${e.toString()}");
      emit(ResetPasswordErrorState());
    });
  }
}
