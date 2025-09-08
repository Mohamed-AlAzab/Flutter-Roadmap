import 'package:flutter_roadmap/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:flutter_roadmap/features/theme/data/repository/theme_repository.dart';
import 'package:flutter_roadmap/features/theme/domain/repository/theme_repository.dart' show ThemeRepository;
import 'package:flutter_roadmap/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:flutter_roadmap/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  getIt.registerSingleton<ThemeLocalDatasource>(
    ThemeLocalDatasource(sharedPreferences: getIt()),
  );
  getIt.registerSingleton<ThemeRepository>(
    ThemeRepositoryImpl(themeLocalDatasource: getIt()),
  );
  getIt.registerSingleton<GetThemeUseCase>(
    GetThemeUseCase(themeRepository: getIt()),
  );
  getIt.registerSingleton<SaveThemeUseCase>(
    SaveThemeUseCase(themeRepository: getIt()),
  );
  getIt.registerFactory(
    () => ThemeBloc(getThemeUseCase: getIt(), saveThemeUseCase: getIt()),
  );



}
