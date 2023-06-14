import 'package:book_store_author/controller/Cubit/Author/author_cubit.dart';
import 'package:book_store_author/model/book.dart';
import 'package:book_store_author/model/books_model.dart';
import 'package:book_store_author/view/widgets/buttonfield.dart';
import 'package:book_store_author/view/widgets/dropmenu.dart';
import 'package:book_store_author/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBook extends StatelessWidget {
  final Books book;

  EditBook({Key? key, required this.book}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController booknameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> items = [
    'Business',
    'Classic',
    'Technology',
    'Fiction',
    'History',
    'Education',
    'Entertainment',
    'Science',
    'Political'
  ];

  @override
  Widget build(BuildContext context) {
    booknameController.text = book.bName!;
    descriptionController.text = book.bDescription!;
    priceController.text = book.bPrice!.toInt().toString();
    return BlocProvider(
      create: (context) => AuthorCubit(),
      child: BlocConsumer<AuthorCubit, AuthorState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthorCubit cubit = AuthorCubit.get(context);
          cubit.editCategory = book.bGenre;
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "Edit Book",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                        key: formKey,
                        child: Center(
                          child: Column(
                            children: [
                              TextFieldWidget(
                                width: 300.w,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter Book Name !",
                                controller: booknameController,
                                title: 'Book Name',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                width: 300.w,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter price !",
                                controller: priceController,
                                title: 'Price',
                              ),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return DropMenu(
                                    width: 300.w,
                                    items: items,
                                    title: 'Category',
                                    value: cubit.editCategory!,
                                    onChange: (value) {
                                      setState(() {
                                        cubit.editCategory = value!;
                                      });
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                width: 300.w,
                                maxLines: 10,
                                validation: (v) {
                                  if (v!.isEmpty) {
                                    return 'required';
                                  }
                                },
                                hintText: "Enter Book Description !",
                                controller: descriptionController,
                                title: 'Description',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: state is EditBookLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      )
                                    : DefaultButton(
                                        height: 40.w,
                                        width: 300.w,
                                        radius: 10,
                                        textSize: 14.sp,
                                        textWeight: FontWeight.bold,
                                        textColor: Colors.white,
                                        text: 'Save',
                                        background: Colors.green,
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.editBook(
                                                context: context,
                                                name: booknameController.text,
                                                description:
                                                    descriptionController.text,
                                                price: double.parse(
                                                    priceController.text),
                                                bookId: book.bId!);
                                            print("clicked!");
                                          }
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ))
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
