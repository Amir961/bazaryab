part of 'splash_bloc.dart';

@immutable
sealed class SplashState {
  final DataApp?  dataApp;

  SplashState({required this.dataApp});
}

final class SplashInitial extends SplashState {
  SplashInitial({required super.dataApp});
}
final class GoToMain extends SplashState {
  GoToMain({required super.dataApp});
}
final class GoToLogin extends SplashState {
  GoToLogin({required super.dataApp});
}

final class NoNetWork extends SplashState {
  NoNetWork({required super.dataApp});
}

final class ErrorNetwork extends SplashState {
  final String message;
  ErrorNetwork({required this.message,required super.dataApp});
}

final class ShowUpdateVersion extends SplashState {
  ShowUpdateVersion({required super.dataApp});
}
