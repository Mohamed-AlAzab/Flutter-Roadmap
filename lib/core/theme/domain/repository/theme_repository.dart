import 'package:flutter_roadmap/core/theme/domain/entity/theme_entity.dart';

abstract class ThemeRepository {
  Future<ThemeEntity> getTheme();
  Future saveTheme(ThemeEntity themeEntity);
}
