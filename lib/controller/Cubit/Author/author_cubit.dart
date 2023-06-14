import 'dart:io';

import 'package:book_store_author/Const/API/Url.dart';
import 'package:book_store_author/Const/component/component.dart';
import 'package:book_store_author/helper/dio_helper/dio_helper.dart';
import 'package:book_store_author/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store_author/model/add_book.dart';
import 'package:book_store_author/model/book.dart';
import 'package:book_store_author/model/books_model.dart';
import 'package:book_store_author/view/Screens/Autor/AuthHome.dart';
import 'package:book_store_author/view/Screens/Autor/add_file.dart';
import 'package:book_store_author/view/Screens/Autor/add_image.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit() : super(AuthorInitial());

  static AuthorCubit get(context) => BlocProvider.of(context);

  String? category = 'Business';
  String? editCategory;
  BookModel? bookModel;
  AddBookModel? addBookModel;

  ///Add Book Data
  void addBookFun({
    required String name,
    required String description,
    required double price,
    required BuildContext context,
  }) async {
    emit(AddBookLoading());
    DioHelper.postData(
        url: ApiUrl.book,
        token: CacheHelper.getData(key: 'token'),
        isJsonContentType: true,
        data: {
          "name": name,
          "description": description,
          "genre": category,
          "price": price
        }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        addBookModel = AddBookModel.fromJson(value.data);
        CacheHelper.saveData(
            key: 'AddBookId', value: addBookModel!.content!.book!.bId);
        replaceTo(context, const AddImage());
      } else {
        print('Something went wrong !');
      }
      emit(AddBookSuccess());
    }).catchError((e) {
      emit(AddBookError());
      print(e.toString());
    });
  }

  ///edit Book Data
  void editBook(
      {required String name,
      Function()? onSuccess,
      required String description,
      required double price,
      required BuildContext context,
      required int bookId}) async {
    emit(EditBookLoading());
    DioHelper.putData(
        url: '${ApiUrl.book}/$bookId',
        token: CacheHelper.getData(key: 'token'),
        data: {
          "name": name,
          "description": description,
          "genre": editCategory,
          "price": price
        }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        replaceTo(context, const AuthHome());
        print('Book edited Successfully');
      } else {
        print('Something went wrong !');
      }
      emit(EditBookSuccess());
    }).catchError((e) {
      emit(EditBookError());
      print(e.toString());
    });
  }

  File? image;

  chooseBookImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(ChooseBookImageState());
  }

  void addBookImage({required BuildContext context}) async {
    emit(UploadImageLoading());
    DioHelper.postData(
        containImage: true,
        url: "${ApiUrl.book}/${CacheHelper.getData(key: 'AddBookId')}/image",
        token: CacheHelper.getData(key: "token"),
        data: {
          "book_id": CacheHelper.getData(key: 'AddBookId'),
          "image": await MultipartFile.fromFile(image!.path,
              filename: image!.path.split('/').last,
              contentType: MediaType('image', 'jpg')),
        }).then((value) {
      print("This is status code:${value.statusCode}");
      if (value.statusCode == 200) {
        replaceTo(context, const AddFile());
        print("This Book Image Updated Successfully !");
      } else {
        print("Somthing went wrong !");
      }
      emit(UploadImageSuccess());
    }).catchError((e) {
      emit(UploadImageError());
    });
  }

  PlatformFile? file;
  String name = '';
  File? _file;

  choosefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      name = result.files.single.name;
      file = result.files.first;
      print(file!.name);
      print(file!.path);
      _file = File(result.files.single.path ?? '');
    } else {
      print('User Cancelled !');
    }
    emit(ChooseBookFileState());
  }

  void addBookFile({required BuildContext context}) async {
    emit(UploadFileLoading());
    DioHelper.postData(
        containImage: true,
        isJsonContentType: false,
        url: "${ApiUrl.book}/${CacheHelper.getData(key: 'AddBookId')}/file",
        token: CacheHelper.getData(key: "token"),
        data: {
          "book_id":  CacheHelper.getData(key: 'AddBookId'),
          "file": await MultipartFile.fromFile(
            _file!.path,
            filename: '${file!.path!.split('/').last}.pdf',
            contentType: MediaType('application', 'pdf'),
          ),
        }).then((value) {
      print("This is status code:${value.statusCode}");
      print(value.data);
      if (value.statusCode == 200) {
        print(value.data);
        CacheHelper.removeData(key: 'AddBookId');
        navigateAndFinish(context, const AuthHome());
        print("This Book File Uploaded Successfully !");
      } else {
        print("Somthing went wrong !");
      }
      emit(UploadFileSuccess());
    }).catchError((e) {
      emit(UploadFileError());
      print(e.toString());
    });
  }

  BooksModel? booksModel;

  void getAuthorBooks() {
    emit(GetAuthorBooksLoading());
    DioHelper.getData(
      url: '${ApiUrl.book}/all',
      token: CacheHelper.getData(key: "token"),
      query: {'author_id': CacheHelper.getData(key: "authId")},
    ).then((value) {
      if (value.statusCode == 200) {
        booksModel = BooksModel.fromJson(value.data);
        print('Author Books get Successfully');
        print(value.data);
      }
      emit(GetAuthorBooksSuccess());
    }).catchError((e) {
      emit(GetAuthorBooksError());
      print(e.toString());
    });
  }

  void deleteBook({
    required int bookId,
    required BuildContext context,
  }) {
    emit(DeleteBookLoading());
    DioHelper.deleteData(
      url: '${ApiUrl.book}/$bookId',
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      if (value.statusCode == 200) {
        print('Book deleted Successfully');
        replaceTo(context, const AuthHome());
        print(value.data);
      }
      emit(DeleteBookSuccess());
    }).catchError((e) {
      emit(DeleteBookError());
      print(e.toString());
    });
  }
}
