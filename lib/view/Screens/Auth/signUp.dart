import 'package:book_store_author/controller/Cubit/SignUp/sign_up_cubit.dart';
import 'package:book_store_author/view/Screens/Auth/login.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/dropmenu.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController fullnameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SignUpCubit.get(context);
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
              title: const Text("Create your account !",
                  style: TextStyle(color: Colors.black)),
            ),
            body: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        width: 300.w,
                        validation: (v) {
                          if (v!.isEmpty) {
                            return 'required';
                          }
                        },
                        hintText: "Enter Your Name !",
                        controller: fullnameController,
                        title: 'Full Name',
                      ),
                      // SizedBox(height: 20),
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
                      //    SizedBox(height: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: StatefulBuilder(
                          builder: (context, setState) => DropMenu(
                              width: 300.w,
                              title: "Gender",
                              items: const [
                                "Male",
                                "Female",
                              ],
                              value: cubit.gender,
                              onChange: (value) {
                                setState(() {
                                  cubit.gender = value!;
                                });
                              }),
                        ),
                      ),
                      const SizedBox(height: 50),
                      state is SignUpLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : DefaultButton(
                              height: 40.w,
                              width: 300.w,
                              radius: 10,
                              textSize: 14.sp,
                              textWeight: FontWeight.bold,
                              textColor: Colors.white,
                              text: 'Sign Up',
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.signup(
                                      userName: fullnameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                      gender: cubit.gender.toString(),
                                      context: context);
                                }
                              },
                            ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already hava an account ?",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text(
                              "Login",
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
