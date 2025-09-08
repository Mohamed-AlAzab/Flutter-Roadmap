part of 'theme_bloc.dart';

enum ThemeStatus { initial, loading, success, error }

class ThemeState {
  final ThemeStatus status;
  final String? errorMassage;
  final ThemeEntity? themeEntity;

  const ThemeState._({
    required this.status,
    this.errorMassage,
    this.themeEntity,
  });

  factory ThemeState.initial() => ThemeState._(status: ThemeStatus.initial);

  ThemeState copyWith({
    ThemeStatus? status,
    String? errorMassage,
    ThemeEntity? themeEntity,
  }) => ThemeState._(
    status: status ?? this.status,
    errorMassage: errorMassage ?? this.errorMassage,
    themeEntity: themeEntity ?? this.themeEntity,
  );
}
