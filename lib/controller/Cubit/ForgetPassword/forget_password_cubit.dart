import 'package:bloc/bloc.dart';
import 'package:book_store_author/Const/API/Url.dart';
import 'package:book_store_author/helper/dio_helper/dio_helper.dart';
import 'package:book_store_author/view/Screens/Auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void forgetpassword({required String email}) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
        url: ApiUrl.forgetPassword,
        isJsonContentType: true,
        data: {"email": email}).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        Get.to(() =>  Verification());
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
      emit(ForgetPasswordSuccessState());
    }).catchError((e) {
      print("this:${e.toString()}");
      emit(ForgetPasswordErrorState());
    });
  }
}
