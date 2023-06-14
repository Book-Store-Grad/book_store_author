import 'package:book_store_author/controller/Cubit/Login/login_cubit.dart';
import 'package:book_store_author/view/Screens/Auth/forget_password.dart';
import 'package:book_store_author/view/Screens/Auth/user_type.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Login to your account",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        width: 300.w,
                        hintText: "Enter your password !",
                        title: "Password",
                        isPassword: true,
                        controller: passwordController,
                        validation: (v) {
                          if (v!.isEmpty) {
                            return 'required';
                          }
                        },
                      ),
                      Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()),
                                );
                              },
                              child: Text(
                                "Forget your password ?",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      state is LoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          : DefaultButton(
                              height: 40.w,
                              width: 300.w,
                              radius: 10,
                              textSize: 14.sp,
                              textWeight: FontWeight.bold,
                              textColor: Colors.white,
                              text: 'Login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  print("clicked!");
                                  cubit.login(
                                      context: context,
                                      userName: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                      SizedBox(
                        height: 20,
                      ),

                      ///Sign In Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't hava an account ?",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserType()),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xffaa1212),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
