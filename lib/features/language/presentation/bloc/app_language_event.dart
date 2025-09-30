part of 'app_language_bloc.dart';

abstract class AppLanguageEvent extends Equatable {
  const AppLanguageEvent();

  @override
  List<Object> get props => [];
}

class SetAppLanguageEvent extends AppLanguageEvent {
  final String tag;

  const SetAppLanguageEvent({
    required this.tag,
  });

  @override
  List<Object> get props => [tag];
}


