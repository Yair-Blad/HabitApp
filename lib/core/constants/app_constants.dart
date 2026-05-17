class AppConstants {
  AppConstants._();

  static const String appName = 'Habito';
  static const String habitsBox = 'habits';
  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';
  static const String onboardingKey = 'onboarding_complete';

  static const int passwordMinLength = 8;

  static List<String> habitIcons = [
    '🏃‍♂️', '💧', '📖', '🧘', '🍎', '🎸',
    '🌱', '💻', '🙏', '🎨', '🏋️', '🧠',
  ];

  static List<int> habitColors = [
    0xFF6750A4, 0xFF0061A4, 0xFF006B3F, 0xFFB83D00,
    0xFFBA1A1A, 0xFF7C4E00, 0xFF006B5E, 0xFF4A0072,
    0xFF005F6E,
  ];
}
