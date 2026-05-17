# Habito

A modern habit tracking application built with Flutter, following Clean Architecture principles and best practices.

## Features

- **Habit Tracking**: Create, track, and manage daily habits
- **Streak Tracking**: Monitor your consistency with streak counters
- **Authentication**: Secure login with email/password validation
- **Google & Apple Sign-In**: Social authentication support (configurable)
- **Dark Mode**: Full dark theme support
- **Modern UI**: Material 3 design with smooth animations
- **Secure Storage**: Tokens and credentials stored via flutter_secure_storage

## Architecture

The project follows **Clean Architecture** with a **Feature-first** approach:

```
lib/
├── core/               # Shared utilities, theme, constants
│   ├── constants/
│   ├── storage/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/           # Authentication feature
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   └── widgets/
│   │   └── providers/
│   └── habits/         # Habits tracking feature
│       ├── models/
│       ├── presentation/
│       │   ├── screens/
│       │   └── widgets/
│       └── providers/
├── app.dart            # App shell & routing
└── main.dart           # Entry point
```

## State Management

Uses **Riverpod** for state management, providing:
- Compile-time safety
- Testability without mocking
- Separation of concerns
- No BuildContext dependency

## Tech Stack

| Technology | Purpose |
|-----------|---------|
| Flutter 3.24+ | UI Framework |
| Riverpod | State Management |
| Hive | Local Storage |
| flutter_secure_storage | Secure Token Storage |
| Material 3 | Design System |

## Getting Started

### Prerequisites

- Flutter SDK >=3.10.0
- Android Studio / VS Code
- Java 17+ for Android builds

### Installation

```bash
# Clone the repository
git clone https://github.com/Yair-Blad/HabitApp.git
cd HabitApp

# Create local.properties for Android
echo "flutter.sdk=$HOME/flutter" > android/local.properties
echo "sdk.dir=$HOME/flutter" >> android/local.properties

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Android Build

```bash
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
flutter run
```

## Project Status

This project is under active development. Features are being added progressively.

## License

MIT
