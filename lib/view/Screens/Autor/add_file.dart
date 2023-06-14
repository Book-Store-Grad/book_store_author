import 'package:book_store_author/controller/Cubit/Author/author_cubit.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFile extends StatelessWidget {
  const AddFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthorCubit(),
        child: BlocConsumer<AuthorCubit, AuthorState>(
          listener: (context, state) {},
          builder: (context, state) {
            AuthorCubit cubit = AuthorCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: const Text(
                  "Add Book File",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: InkWell(
                          onTap: () async {
                            await cubit.choosefile();
                          },
                          child: cubit.file != null
                              ? Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    height: 40.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const Icon(Icons.picture_as_pdf,
                                            color: Colors.red)
                                      ],
                                    ),
                                  ),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    width: 200.w,
                                    height: 250.h,
                                    child: Image.asset(
                                      'assets/images/file-templete.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      state is UploadFileLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                          : cubit.file == null
                              ? const SizedBox()
                              : DefaultButton(
                                  height: 40.w,
                                  width: 300.w,
                                  radius: 10,
                                  textSize: 14.sp,
                                  textWeight: FontWeight.bold,
                                  textColor: Colors.white,
                                  text: 'Finish',
                                  background: Colors.green,
                                  function: () {
                                    cubit.addBookFile(context: context);
                                  },
                                ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
