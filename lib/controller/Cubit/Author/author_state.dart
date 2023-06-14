part of 'author_cubit.dart';

@immutable
abstract class AuthorState {}

class AuthorInitial extends AuthorState {}

///Get All Books
class GetAuthorBooksLoading extends AuthorState {}

class GetAuthorBooksSuccess extends AuthorState {}

class GetAuthorBooksError extends AuthorState {}

///Add Book
class AddBookLoading extends AuthorState {}

class AddBookSuccess extends AuthorState {}

class AddBookError extends AuthorState {}

///Add Book Image
class AddBookImageLoading extends AuthorState {}

class AddBookImageSuccess extends AuthorState {}

class AddBookImageError extends AuthorState {}

///Add Book File
class AddBookFileLoading extends AuthorState {}

class AddBookFileSuccess extends AuthorState {}

class AddBookFileError extends AuthorState {}

///Edit Book
class EditBookLoading extends AuthorState {}

class EditBookSuccess extends AuthorState {}

class EditBookError extends AuthorState {}

///Delete Book
class DeleteBookLoading extends AuthorState {}

class DeleteBookSuccess extends AuthorState {}

class DeleteBookError extends AuthorState {}

///Get Book Detail

class GetBookLoading extends AuthorState {}

class GetBookSuccess extends AuthorState {}

class GetBookError extends AuthorState {}

///Image

class ChooseBookImageState extends AuthorState {}

class UploadImageLoading extends AuthorState {}

class UploadImageSuccess extends AuthorState {}

class UploadImageError extends AuthorState {}

///File

class ChooseBookFileState extends AuthorState {}

class UploadFileLoading extends AuthorState {}

class UploadFileSuccess extends AuthorState {}

class UploadFileError extends AuthorState {}