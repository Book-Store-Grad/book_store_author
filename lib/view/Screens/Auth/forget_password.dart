import 'package:book_store_author/controller/Cubit/ForgetPassword/forget_password_cubit.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ForgetPasswordCubit.get(context);
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
              title: const Text("Forget Password",
                  style: TextStyle(color: Colors.black)),
            ),
            body: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      width: 300.w,
                      validation: (v) {
                        if (v!.isEmpty) {
                          return 'required';
                        }
                      },
                      hintText: "Enter Your Email !",
                      controller: emailController,
                      title: 'Email',
                    ),
                    SizedBox(height: 50),
                    state is ForgetPasswordLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : DefaultButton(
                            height: 40.w,
                            width: 300.w,
                            radius: 10,
                            textSize: 14.sp,
                            textWeight: FontWeight.bold,
                            textColor: Colors.white,
                            text: 'Send Code',
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.forgetpassword(
                                    email: emailController.text);
                                CacheHelper.saveData(key:"email", value:  emailController.text);
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
