part of 'splash_load_bloc.dart';

abstract class SplashLoadEvent extends Equatable {
  const SplashLoadEvent();

  @override
  List<Object> get props => [];
}

class GetSplashLoadEvent extends SplashLoadEvent {}

class GetSplashChangeSettingsEvent extends SplashLoadEvent {}
