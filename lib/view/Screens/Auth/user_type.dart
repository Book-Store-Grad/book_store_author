import 'package:book_store_author/Const/component/component.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/view/Screens/Auth/signUp.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UserType extends StatelessWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Sign Up",
            style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text("Sign Up as",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),
            DefaultButton(
              height: 40.w,
              width: 300.w,
              radius: 15,
              background:const Color(0xff00A3FF) ,
              textSize: 14.sp,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
              text: 'Author',
              function: () {
                CacheHelper.saveData(key: 'signupRole', value: 'author');
                navigateTo(context, const SignUp());
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child:  Text("Or",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),

            DefaultButton(
              height: 40.w,
              width: 300.w,
              radius: 15,
              textSize: 14.sp,
              textWeight: FontWeight.bold,
              textColor: Colors.white,
              text: 'Customer',
              function: () {
                CacheHelper.saveData(key: 'signupRole', value: 'customer');
                navigateTo(context, const SignUp());
              },
            ),
          ],
        ),
      ),
    );
  }
}
