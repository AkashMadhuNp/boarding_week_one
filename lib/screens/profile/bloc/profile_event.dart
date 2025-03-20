import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class SignOutEvent extends ProfileEvent {
  final BuildContext context;

  SignOutEvent(this.context);

  @override
  List<Object?> get props => [context];
}

