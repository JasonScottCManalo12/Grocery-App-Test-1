# Grocery App Test 1

A simple Flutter grocery shopping list app.

## Features

- Add grocery items
- Mark items as bought (checkbox)
- Swipe or tap to delete items
- Clean Material 3 UI

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0 or higher)
- A code editor (VS Code, Android Studio, etc.)

### Run the app

```bash
# Get dependencies
flutter pub get

# Run on connected device / emulator / Chrome
flutter run
```

### Project structure

```
lib/
  main.dart          # App entry point + Grocery List UI
test/
  widget_test.dart   # Basic widget test
pubspec.yaml         # Dependencies
```

## Next steps ideas

- Persist the list (shared_preferences / hive / sqlite)
- Categories (Fruits, Dairy, etc.)
- Quantity & unit
- Dark mode toggle
- Share list
