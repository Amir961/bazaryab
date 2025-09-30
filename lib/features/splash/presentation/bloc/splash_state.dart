part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}
final class GotToMain extends SplashState {}
final class GotToLogin extends SplashState {}
