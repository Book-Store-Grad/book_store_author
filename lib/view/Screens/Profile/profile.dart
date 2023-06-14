import 'package:book_store_author/Const/component/component.dart';
import 'package:book_store_author/controller/Cubit/Profile/profile_cubit.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/view/Screens/Auth/login.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/dropmenu.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/API/Url.dart';
import '../../../Const/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ['male', 'female'];
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: const Text(
                'My Profile',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: cubit.profile == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : ListView(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      CacheHelper.removeData(key: 'role');
                                      token='';
                                      role='';
                                      CacheHelper.removeData(key: "token")
                                          .then((value) {
                                        navigateAndFinish(
                                            context, const Login());
                                      });
                                    },
                                    icon:
                                        Image.asset('assets/icons/logout.png'),
                                    iconSize: 40,
                                  )
                                ],
                              ),
                            ),
                            state is GetProfileImageLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : InkWell(
                                    onTap: () async {
                                      await cubit.chooseProfileImage();
                                    },
                                    child: Card(
                                      shape: const CircleBorder(),
                                      elevation: 10,
                                      shadowColor: Colors.red,
                                      child: Container(
                                        width: 150.w,
                                        height: 150.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: cubit.image != null
                                            ? Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: const CircleBorder(),
                                                elevation: 10,
                                                child: Image.file(
                                                  cubit.image!,
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                            : Card(
                                                shape: const CircleBorder(),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.network(
                                                  ApiUrl.base +
                                                      ApiUrl.profileImage,
                                                  fit: BoxFit.contain,
                                                  headers: {
                                                    "Authorization":
                                                        "Bearer ${CacheHelper.getData(key: "token")}",
                                                  },
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Center(
                                                    child: Container(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/profile.png",
                                                        width: 130.w,
                                                        height: 150.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                            state is UpdateProfileImageLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.red,
                                  )
                                : cubit.image == null
                                    ? const SizedBox()
                                    : TextButton(
                                        onPressed: () {
                                          cubit.updateProfileImage();
                                        },
                                        child: const Text(
                                          "Upload",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                      ),
                            TextFieldWidget(
                              width: 300.w,
                              hintText: "Enter your name !",
                              title: "Name",
                              controller: cubit.nameController,
                              validation: (v) {
                                if (v!.isEmpty) {
                                  return 'required';
                                }
                              },
                            ),
                            TextFieldWidget(
                              enabled: false,
                              width: 300.w,
                              hintText: "Enter your email !",
                              title: "Email",
                              controller: cubit.emailController,
                              validation: (v) {
                                if (v!.isEmpty) {
                                  return 'required';
                                }
                              },
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => DropMenu(
                                width: 300.w,
                                items: items,
                                title: 'Gender',
                                value: cubit.gender,
                                onChange: (value) {
                                  setState(() {
                                    cubit.gender = value!;
                                  });
                                },
                              ),
                            ),
                            state is ProfileLoadingState
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: DefaultButton(
                                      height: 40.w,
                                      width: 300.w,
                                      radius: 10,
                                      textSize: 14.sp,
                                      textWeight: FontWeight.bold,
                                      textColor: Colors.white,
                                      text: 'Save',
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          print("clicked!");
                                          cubit.updateProfile(
                                              name: cubit.nameController.text);
                                        }
                                      },
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
