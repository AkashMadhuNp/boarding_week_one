import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String? username;
  final String? email;
  final String? profileImageUrl;

  ProfileLoaded({
    this.username,
    this.email,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [username, email, profileImageUrl];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class SigningOut extends ProfileState {}

class SignedOut extends ProfileState {}
