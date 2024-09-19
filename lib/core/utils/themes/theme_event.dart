abstract class ThemeEvent {}

class FetchThemeEvent implements ThemeEvent {}

class UpdateThemeEvent implements ThemeEvent {
  final bool isDarkMode;

  UpdateThemeEvent(this.isDarkMode);
}
