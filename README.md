# Grocery App Test 1

A simple and clean Flutter grocery shopping list app.

## Features

- Add grocery items quickly
- Mark items as bought with a checkbox
- Swipe left or tap delete to remove items
- Clean Material 3 design with green theme
- Empty state when the list is empty

## Download the APK (for phone)

You can install the app directly on your Android phone without a computer:

1. Go to the **Actions** tab:  
   [https://github.com/JasonScottCManalo12/Grocery-App-Test-1/actions](https://github.com/JasonScottCManalo12/Grocery-App-Test-1/actions)
2. Open the latest successful run (green check)
3. Scroll down to **Artifacts**
4. Download `grocery-app-apk`
5. Unzip the file and install `app-release.apk` on your phone

> Note: You may need to allow "Install from unknown sources" on your phone.

## Run from source (for developers)

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0 or higher)
- Android Studio or VS Code

### Steps

```bash
# Clone the repository
git clone https://github.com/JasonScottCManalo12/Grocery-App-Test-1.git
cd Grocery-App-Test-1

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure

```
Grocery-App-Test-1/
├── lib/
│   └── main.dart              # Main app code
├── android/                   # Android platform files
├── test/
│   └── widget_test.dart       # Basic tests
├── .github/workflows/
│   └── build-apk.yml          # Automatic APK build
├── pubspec.yaml               # Dependencies
└── README.md
```

## How the APK is built

Every time code is pushed to the `main` branch, GitHub Actions automatically builds a release APK. You can also trigger a build manually from the Actions tab.

## Future ideas

- Save the list permanently (so it doesn't reset when you close the app)
- Add categories (Fruits, Dairy, Snacks, etc.)
- Add quantity (e.g. 2x Milk)
- Dark mode
- Share list with others

---

Made with Flutter
