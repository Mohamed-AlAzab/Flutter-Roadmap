part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetThemeEvent extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}