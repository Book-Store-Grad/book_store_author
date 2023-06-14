part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class GetProfileImageSuccessState extends ProfileState {}

class GetProfileImageLoadingState extends ProfileState {}

class GetProfileImageErrorState extends ProfileState {}

class UpdateProfileImageLoadingState extends ProfileState {}

class UpdateProfileImageSuccessState extends ProfileState {}

class UpdateProfileImageErrorState extends ProfileState {}

class ChooseImageState extends ProfileState {}