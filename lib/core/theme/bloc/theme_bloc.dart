import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_roadmap/core/theme/domain/entity/theme_entity.dart';
import 'package:flutter_roadmap/core/theme/domain/usecase/get_theme_use_case.dart';
import 'package:flutter_roadmap/core/theme/domain/usecase/save_theme_use_case.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.saveThemeUseCase})
    : super(ThemeState.initial()) {
    on<GetThemeEvent>(onGetThemeEvent);
    on<ToggleThemeEvent>(onToggleThemeEvent);
  }

  FutureOr<void> onGetThemeEvent(
    GetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(status: ThemeStatus.loading));
    try {
      var result = await getThemeUseCase();
      emit(state.copyWith(status: ThemeStatus.success, themeEntity: result));
    } catch (e) {
      emit(
        state.copyWith(status: ThemeStatus.error, errorMassage: e.toString()),
      );
    }
  }

  FutureOr<void> onToggleThemeEvent(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state.themeEntity != null) {
      var newThemeType = state.themeEntity!.themeType == ThemeType.dark
          ? ThemeType.light
          : ThemeType.dark;
      var newThemeEntity = ThemeEntity(themeType: newThemeType);
      try {
        await saveThemeUseCase(newThemeEntity);
        emit(state.copyWith(status: ThemeStatus.success, themeEntity: newThemeEntity));
      } catch (e) {
        emit(
          state.copyWith(status: ThemeStatus.error, errorMassage: e.toString()),
        );
      }
    }
  }
}
