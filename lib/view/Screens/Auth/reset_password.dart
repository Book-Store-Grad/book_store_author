import 'package:book_store_author/controller/Cubit/ResetPassword/reset_password_cubit.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController resetPasswordController =
        TextEditingController();
    final TextEditingController resetConfirmPasswordController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ResetPasswordCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/images/back.png'),
              ),
              title: const Text("Reset Password",
                  style: TextStyle(color: Colors.black)),
            ),
            body: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      isPassword: true,
                      width: 300.w,
                      validation: (v) {
                        if (v!.isEmpty) {
                          return 'required';
                        }
                      },
                      hintText: "Enter your new password !",
                      controller: resetPasswordController,
                      title: 'Password',
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      isPassword: true,
                      width: 300.w,
                      validation: (v) {
                        if (v!.isEmpty) {
                          return 'required';
                        } else if (resetPasswordController.text !=
                            resetConfirmPasswordController.text) {
                          return "Password doesn't match";
                        }
                      },
                      hintText: "Re-Enter your password !",
                      controller: resetConfirmPasswordController,
                      title: 'Confirm Password',
                    ),
                    SizedBox(height: 50),
                    state is ResetPasswordLoadingState
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                        :
                    DefaultButton(
                      height: 40.w,
                      width: 300.w,
                      radius: 10,
                      textSize: 14.sp,
                      textWeight: FontWeight.bold,
                      textColor: Colors.white,
                      text: 'Reset',
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.resetpasword(
                              password: resetPasswordController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
