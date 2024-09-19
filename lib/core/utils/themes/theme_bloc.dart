import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/domain/repository/repository_barrel.dart';
import '../utils_barrel.dart';



class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Repository repository;

  ThemeBloc(this.repository) : super(ThemeState.lightTheme) {
    on<FetchThemeEvent>((event, emit) async {
      bool isDark = await repository.isDark();
      emit(isDark ? ThemeState.darkTheme : ThemeState.lightTheme);
    });

    on<UpdateThemeEvent>((event, emit) async {
      bool success = await repository.updateThemeMode(isDark: event.isDarkMode);
      if (success) {
        emit(event.isDarkMode ? ThemeState.darkTheme : ThemeState.lightTheme);
      }
    });
  }
}
