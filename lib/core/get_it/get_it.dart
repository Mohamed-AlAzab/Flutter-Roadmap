import 'package:flutter_roadmap/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/delete_account_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/logout_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/signin_with_github_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/signin_with_google_usecase.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/features/courses/data/repository/courses_repository_impl.dart';
import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/add_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/delete_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/edit_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/get_all_courses_use_case.dart';
import 'package:flutter_roadmap/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:flutter_roadmap/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:flutter_roadmap/features/theme/data/repository/theme_repository.dart';
import 'package:flutter_roadmap/features/theme/domain/repository/theme_repository.dart'
    show ThemeRepository;
import 'package:flutter_roadmap/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:flutter_roadmap/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getIt = GetIt.instance;
// dependance injection
Future<void> init() async {
  // Theme
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

  // Auth
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<GetCurrentUserUsecase>(
    GetCurrentUserUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<LoginUserUsecase>(
    LoginUserUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<RegisterUserUsecase>(
    RegisterUserUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<ResetPasswordByEmailUsecase>(
    ResetPasswordByEmailUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<LogoutUserUsecase>(
    LogoutUserUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<DeleteAccountUsecase>(
    DeleteAccountUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<SigninWithGoogleUsecase>(
    SigninWithGoogleUsecase(authRepository: getIt()),
  );
  getIt.registerSingleton<SigninWithGithubUsecase>(
    SigninWithGithubUsecase(authRepository: getIt()),
  );
  getIt.registerFactory(
    () => AuthBloc(
      getCurrentUserUsecase: getIt(),
      loginUserUsecase: getIt(),
      registerUserUsecase: getIt(),
      resetPasswordByEmailUsecase: getIt(),
      logoutUserUsecase: getIt(),
      deleteAccountUsecase: getIt(),
      signinWithGoogleUsecase: getIt(),
      signInWithGithubUsecase: getIt(),
    ),
  );

  // Course
  getIt.registerSingleton<CoursesRepository>(CoursesRepositoryImpl());
  getIt.registerSingleton<GetAllCoursesUseCase>(
    GetAllCoursesUseCase(coursesRepository: getIt()),
  );
  getIt.registerSingleton<AddCourseUseCase>(
    AddCourseUseCase(coursesRepository: getIt()),
  );
  getIt.registerSingleton<EditCourseUseCase>(
    EditCourseUseCase(coursesRepository: getIt()),
  );
  getIt.registerSingleton<DeleteCourseUseCase>(
    DeleteCourseUseCase(coursesRepository: getIt()),
  );
  getIt.registerFactory(
    () => CoursesBloc(
      addCourseUseCase: getIt(),
      deleteCourseUseCase: getIt(),
      editCourseUseCase: getIt(),
      getAllCoursesUseCase: getIt(),
    ),
  );
}
