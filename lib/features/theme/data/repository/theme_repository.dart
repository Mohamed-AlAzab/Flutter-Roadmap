import 'package:flutter_roadmap/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:flutter_roadmap/features/theme/domain/repository/theme_repository.dart';
import 'package:flutter_roadmap/features/theme/domain/entity/theme_entity.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<ThemeEntity> getTheme() async {
    return await themeLocalDatasource.getTheme();
  }

  @override
  Future saveTheme(ThemeEntity themeEntity) async {
    await themeLocalDatasource.saveTheme(themeEntity);
  }
}
