import 'package:book_store_author/Const/API/Url.dart';
import 'package:book_store_author/Const/component/component.dart';
import 'package:book_store_author/helper/dio_helper/dio_helper.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/model/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../view/Screens/Autor/AuthHome.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void login({
    required String userName,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(isJsonContentType: false, url: ApiUrl.login, data: {
      "username": userName,
      "password": password,
    }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200 ) {
        loginModel = LoginModel.fromJson(value.data);
        CacheHelper.saveData(key: "token", value: loginModel!.accessToken);
        CacheHelper.saveData(
            key: "role", value: loginModel!.content!.user!.uRole);
        int? userId = loginModel!.content!.user!.uId;
        CacheHelper.saveData(key: 'authId', value: userId);
        print("this is token : ${CacheHelper.getData(key: "token")}");
        print("account role : ${CacheHelper.getData(key: "role")}");
        if(loginModel!.content!.user!.uRole =='author'){
          navigateAndFinish(context, const AuthHome());
        }
      } else {
        Get.snackbar("Error", "",
            maxWidth: 400,
            messageText: const Text(
              "Wrong Email or Password",
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
      emit(LoginSuccessState());
    }).catchError((e) {
      print("this:${e.toString()}");
      emit(LoginErrorState());
    });
  }
}
