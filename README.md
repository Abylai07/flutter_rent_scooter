# ScooterShare

A professional electric scooter sharing platform built with Flutter. This mono-repository showcases advanced mobile development practices including complex state management, real-time tracking, payment processing, and scalable architecture.

## Project Overview

This is a production-ready multi-app Flutter project that includes:

- **Mobile App**: User-facing application for renting and riding electric scooters
- **Admin App**: Fleet management dashboard for operations team
- **Shared Library**: Common components, utilities, and business logic

## Core Features

### Ride Management
- **Real-time Ride Tracking**: Live location updates every 5 seconds with route recording
- **Smart Ride Session**: Complex BLoC managing ride state, pause/resume, distance calculation
- **Cost Estimation**: Real-time fare calculation with pause time discounts
- **Ride Limits**: Automatic enforcement of max distance (50km) and duration (8 hours)
- **Ride History**: Complete ride analytics with speed, distance, and cost breakdowns

### Scooter Discovery
- **Interactive Map**: 2GIS SDK integration with cluster support for nearby scooters
- **Advanced Filtering**: Filter by battery level, distance, price, and availability
- **Real-time Search**: Search scooters by ID, device code, or QR code
- **Smart Sorting**: Automatically sort scooters by proximity to user
- **Reservation System**: Reserve scooters for up to 15 minutes
- **Auto-refresh**: Background updates every 30 seconds for scooter availability

### Payment & Wallet
- **Multi-payment Support**: Credit cards, Apple Pay, Google Pay, wallet balance
- **Smart Wallet**: Top-up with automatic bonus rewards (5-10% based on amount)
- **Promo Codes**: Apply discount codes with validation
- **Transaction History**: Complete payment audit trail
- **Loyalty Program**: Earn points on every ride (10 points per $1)
- **Bonus System**: Use bonus balance to offset ride costs

### Security & Auth
- **JWT Authentication**: Secure token-based auth with refresh logic
- **Biometric Login**: Face ID / Touch ID support
- **KYC Verification**: Multi-step identity verification flow
- **Secure Storage**: Encrypted storage for tokens and sensitive data
- **PIN Protection**: Optional 4-digit PIN for quick app access

## Tech Stack & Architecture

### Core Technologies
- **Flutter**: 3.6+ with Dart 3.6+
- **State Management**: BLoC pattern with advanced event-driven architecture
- **Networking**: Dio + Retrofit for type-safe REST clients
- **Navigation**: Auto Route with deep linking support
- **Maps**: 2GIS SDK with real-time location tracking
- **Storage**: GetStorage (preferences) + Flutter Secure Storage (tokens)
- **Code Generation**: Freezed, json_serializable, build_runner

### Complex BLoC Implementations

#### RideSessionBloc
Manages the entire ride lifecycle with sophisticated state management:
- Timer-based location tracking (5s intervals)
- Distance calculation using Geolocator haversine formula
- Real-time cost estimation with pause time discounts
- Route recording with GPS coordinates and metadata
- Automatic ride limit enforcement
- Battery level monitoring
- Average speed calculation

```dart
sealed class RideSessionState {
  RideSessionInitial
  RideSessionLoading
  RideSessionUnlocked
  RideSessionActive(session, speed, estimatedCost, warnings)
  RideSessionPaused(session, pauseStartTime)
  RideSessionCompleted(session, summary)
  RideSessionError
}
```

#### ScooterMapBloc
Advanced scooter discovery and filtering system:
- Real-time scooter position updates
- Multi-criteria filtering (battery, distance, price, status)
- Full-text search across multiple fields
- Distance-based sorting algorithm
- Reservation state management
- Favorite scooters tracking
- Auto-refresh with configurable intervals

#### PaymentBloc
Complete payment processing system:
- Multi-payment method support
- Wallet balance management
- Bonus and promo code application
- Transaction history tracking
- Loyalty points calculation
- Refund handling
- Payment retry logic

## Project Structure

```
apps/
├── mobile-app/                    # User-facing scooter rental app
│   ├── lib/src/
│   │   ├── features/
│   │   │   ├── ride/              # Ride session management
│   │   │   │   └── bloc/          # RideSessionBloc (complex logic)
│   │   │   ├── scooter_map/       # Map with scooter discovery
│   │   │   │   └── bloc/          # ScooterMapBloc (search & filter)
│   │   │   ├── payment/           # Wallet & payments
│   │   │   │   └── bloc/          # PaymentBloc (transactions)
│   │   │   ├── auth/              # Authentication flow
│   │   │   ├── verification/      # KYC verification
│   │   │   ├── profile/           # User profile & settings
│   │   │   ├── qr_scanner/        # QR code scanning
│   │   │   └── pin_code/          # PIN protection
│   │   └── core/                  # App utilities
│   └── assets/
├── mobile-admin/                  # Fleet management dashboard
│   └── lib/core/
└── mobile-shared/                 # Shared library
    └── lib/
        ├── core/
        │   ├── config/            # EnvConfig for environment vars
        │   ├── models/
        │   │   ├── scooter/       # ScooterModel with status
        │   │   ├── ride/          # RideSessionModel with tracking
        │   │   └── payment/       # WalletModel, TransactionModel
        │   ├── utils/
        │   │   ├── networking/    # Dio + Retrofit clients
        │   │   └── constants/     # AppConstants
        │   ├── widgets/           # Reusable UI components
        │   └── style/             # Design system
        └── gen/                   # Generated code

```

### Architecture Highlights

#### Advanced BLoC Patterns
- **Event-driven**: All user actions and system events trigger state changes
- **Reactive streams**: Real-time updates using Stream controllers
- **Timer-based logic**: Location updates, auto-refresh, ride duration
- **Complex calculations**: Distance, speed, cost estimation algorithms
- **Error recovery**: Graceful handling with state preservation

#### Data Models with Freezed
- **Immutability**: All models are immutable data classes
- **Union types**: Sealed classes for exhaustive state handling
- **JSON serialization**: Auto-generated serializers
- **Copy-with**: Easy state updates without mutation

#### Dependency Injection
- Provider for global dependencies (RestClient, Storage)
- BLoC factory constructors for scoped dependencies
- Lazy initialization for performance

## Getting Started

### Prerequisites

- Flutter SDK 3.6.0+
- Dart 3.6.0+
- Melos CLI
- Android Studio / Xcode
- 2GIS API Key

### Quick Start

1. **Clone and setup**:
```bash
git clone <repository-url>
cd mobile-mono
dart pub global activate melos
melos bootstrap
```

2. **Configure environment**:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. **Setup 2GIS API Key**:
```bash
echo "your_api_key" > apps/mobile-app/assets/dgissdk.key
```

4. **Generate code**:
```bash
melos run build
melos run gen_l10n
```

5. **Run the app**:
```bash
cd apps/mobile-app
flutter run --dart-define=API_BASE_URL=https://api.example.com/
```

For detailed setup instructions, see [SETUP.md](SETUP.md).

## Development

### Available Scripts

```bash
melos run clean          # Clean build artifacts
melos run get            # Get dependencies
melos run build          # Generate code
melos run watch          # Watch and rebuild
melos run gen_l10n       # Generate localizations
```

### Project Structure

This mono-repo uses **Melos** for managing multiple packages. Each app shares the `mobile-shared` package which contains:

- Common UI components
- Network clients and API models
- Utilities and helpers
- Theme and design system
- Localization

### Configuration Management

Environment-specific configuration is handled through `EnvConfig`:

```dart
final config = EnvConfig.fromEnvironment();
final apiUrl = config.apiBaseUrl;
```

Build with custom config:
```bash
flutter build apk \
  --dart-define=API_BASE_URL=https://api.prod.com/ \
  --dart-define=MAP_API_KEY=your_key \
  --dart-define=DEBUG_MODE=false
```

## API Integration

The app communicates with a RESTful backend API:

- Authentication endpoints (`/auth/*`)
- Device management (`/devices/*`)
- User verification (`/verification/*`)

API client is auto-generated using Retrofit with type-safe models.

## Contributing

We follow standard Git workflow:

1. Create a feature branch
2. Make your changes
3. Run `melos run build` if needed
4. Test on both platforms
5. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Security

- API keys and secrets are managed via environment variables
- Sensitive data stored in Flutter Secure Storage
- JWT tokens for API authentication
- Certificate pinning ready
- Biometric authentication support

**Never commit**:
- `.env` files
- `dgissdk.key` files
- `key.properties` files
- Any credentials or secrets

## License

Proprietary - All rights reserved

## Support

For issues and questions, please open an issue in the repository.
