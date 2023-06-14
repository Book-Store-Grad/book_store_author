import 'package:book_store_author/controller/Cubit/Verification/verification_cubit.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/view/Screens/Auth/reset_password.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();
    const borderColor = Color.fromRGBO(150, 157, 156, 0.4);

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = VerificationCubit.get(context);
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
              title: const Text("Verification",
                  style: TextStyle(color: Colors.black)),
            ),
            body: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "You will receive a verification code in a moment !",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      validator: (v) {
                        if (v!.isEmpty || v.length < 4) {
                          return "Pin is required !";
                        }
                      },
                      defaultPinTheme: defaultPinTheme,
                    ),
                    SizedBox(height: 50),
                    DefaultButton(
                      height: 40.w,
                      width: 300.w,
                      radius: 10,
                      textSize: 14.sp,
                      textWeight: FontWeight.bold,
                      textColor: Colors.white,
                      text: 'Continue',
                      function: () {
                        focusNode.unfocus();
                        if (_formKey.currentState!.validate()) {
                          Get.to(() => const ResetPassword());
                          print(pinController.text);
                          CacheHelper.saveData(
                              key: "code", value: pinController.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    state is VerificationLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              cubit.resendCode(
                                  email: CacheHelper.getData(key: "email"));
                            },
                            child: const Text(
                              "Re-send Code",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff3669C9),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
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
