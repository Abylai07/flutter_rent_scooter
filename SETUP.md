# Setup Guide

This guide will help you set up the development environment for the Mobility Hub project.

## Prerequisites

- **Flutter SDK**: 3.6.0 or higher
- **Dart SDK**: 3.6.0 or higher (included with Flutter)
- **FVM** (Flutter Version Manager): Recommended for version consistency
- **Melos**: For managing the mono-repository
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter/Dart plugins

### Platform-Specific Requirements

#### Android
- Android Studio
- Android SDK (API level 21+)
- Java JDK 17 or higher
- Gradle 8.x

#### iOS
- Xcode 15+
- CocoaPods
- iOS 12.0+ deployment target
- macOS for iOS development

## Initial Setup

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd mobile-mono
```

### 2. Install Melos

```bash
dart pub global activate melos
```

### 3. Bootstrap the Project

This command will install all dependencies for all packages in the mono-repo:

```bash
melos bootstrap
```

### 4. Configure Environment Variables

Copy the example environment file and configure your values:

```bash
cp .env.example .env
```

Edit `.env` and fill in your configuration:

```bash
# API Configuration
API_BASE_URL=https://your-api-url.com/

# Map API Key (2GIS SDK)
MAP_API_KEY=your_map_api_key_here

# Debug Configuration
DEBUG_MODE=true

# API Timeout (seconds)
API_TIMEOUT=30
```

### 5. Configure 2GIS Map SDK Key

The application uses 2GIS SDK for maps. You need to obtain an API key:

1. Register at [2GIS Developer Portal](https://dev.2gis.com/)
2. Create a new project and get your API key
3. Create the key file:

```bash
# For mobile-app
echo "your_2gis_api_key_here" > apps/mobile-app/assets/dgissdk.key
```

**Important**: Never commit the `dgissdk.key` file to version control!

### 6. Generate Code

Generate necessary code files (serialization, routing, etc.):

```bash
melos run build
```

### 7. Generate Localization Files

```bash
melos run gen_l10n
```

## Running the Application

### Development Mode

#### Mobile App (User-facing)
```bash
cd apps/mobile-app
flutter run --dart-define=API_BASE_URL=https://your-api.com/ --dart-define=MAP_API_KEY=your_key
```

#### Admin App
```bash
cd apps/mobile-admin
flutter run --dart-define=API_BASE_URL=https://your-api.com/
```

### Using Environment Variables from .env

You can source the .env file and use variables:

```bash
# Load environment variables
source .env

# Run with environment variables
flutter run \
  --dart-define=API_BASE_URL=$API_BASE_URL \
  --dart-define=MAP_API_KEY=$MAP_API_KEY \
  --dart-define=DEBUG_MODE=$DEBUG_MODE
```

### Release Build

#### Android
```bash
cd apps/mobile-app
flutter build apk --release \
  --dart-define=API_BASE_URL=$PROD_API_BASE_URL \
  --dart-define=MAP_API_KEY=$MAP_API_KEY \
  --dart-define=DEBUG_MODE=false
```

#### iOS
```bash
cd apps/mobile-app
flutter build ios --release \
  --dart-define=API_BASE_URL=$PROD_API_BASE_URL \
  --dart-define=MAP_API_KEY=$MAP_API_KEY \
  --dart-define=DEBUG_MODE=false
```

## Melos Scripts

The project includes several Melos scripts for common tasks:

### Clean
Remove all build artifacts:
```bash
melos run clean
```

### Get Dependencies
Fetch dependencies for all packages:
```bash
melos run get
```

### Build Runner
Generate code (serialization, routing, etc.):
```bash
melos run build
```

Watch for changes and rebuild:
```bash
melos run watch
```

### FlutterGen
Generate assets references:
```bash
melos run fluttergen
```

### Localization
Generate localization files:
```bash
melos run gen_l10n
```

### Auto Fix
Apply automated fixes:
```bash
melos run auto_fix
```

### Upgrade Dependencies
Upgrade all dependencies:
```bash
melos run upgrade_dependencies
```

### Pod Install (iOS)
Install CocoaPods dependencies:
```bash
melos run pod_install
```

## Project Structure

```
mobile-mono/
├── apps/
│   ├── mobile-app/        # Main user-facing application
│   ├── mobile-admin/      # Admin dashboard application
│   └── mobile-shared/     # Shared components, utilities, and widgets
├── .env.example           # Environment configuration template
├── melos.yaml            # Melos configuration
└── pubspec.yaml          # Root dependencies
```

## Common Issues and Solutions

### Issue: "No such file or directory: dgissdk.key"

**Solution**: Create the dgissdk.key file as described in step 5 above.

### Issue: Build runner fails

**Solution**: Clean and rebuild:
```bash
melos run clean
melos bootstrap
melos run build
```

### Issue: iOS build fails

**Solution**: Clean and reinstall pods:
```bash
cd apps/mobile-app/ios
rm -rf Pods Podfile.lock
pod install
cd ../../..
```

### Issue: "API_BASE_URL is required" error

**Solution**: Make sure you're passing the dart-define parameters:
```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com/
```

## Development Workflow

1. Create a new feature branch
2. Make your changes
3. Run `melos run build` if you modified models or generated code
4. Test your changes on both iOS and Android
5. Run `melos run auto_fix` to apply automated fixes
6. Commit and push your changes
7. Create a pull request

## IDE Setup

### VS Code

Recommended extensions:
- Flutter
- Dart
- Dart Data Class Generator
- Flutter Intl

### Android Studio / IntelliJ IDEA

Plugins:
- Flutter
- Dart
- Flutter Intl

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Melos Documentation](https://melos.invertase.dev/)
- [2GIS SDK Documentation](https://docs.2gis.com/)

## Support

For issues and questions, please open an issue in the repository.
