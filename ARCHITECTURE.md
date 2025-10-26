# Architecture Documentation

## Overview

This project implements a **mono-repository architecture** with multiple Flutter applications sharing common code. The architecture emphasizes modularity, testability, and scalability.

## Mono-Repository Structure

```
mobile-mono/
├── apps/
│   ├── mobile-app/      # Consumer app
│   ├── mobile-admin/    # Admin dashboard
│   └── mobile-shared/   # Shared library
├── melos.yaml          # Mono-repo configuration
└── .env.example        # Environment template
```

### Why Mono-repo?

- **Code Reuse**: Share widgets, utilities, and business logic
- **Consistent Versioning**: All apps use same dependency versions
- **Atomic Changes**: Update shared code and consumers together
- **Simplified CI/CD**: Single pipeline for all apps

## Application Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (Widgets, BLoCs, UI Logic)       │
├─────────────────────────────────────┤
│         Domain Layer                │
│    (Business Logic, Use Cases)      │
├─────────────────────────────────────┤
│         Data Layer                  │
│    (API Clients, Models, Storage)   │
└─────────────────────────────────────┘
```

### Feature-Based Organization

Each feature is self-contained:

```
features/auth/
├── auth_view.dart           # UI
├── bloc/                    # State management
│   ├── auth_bloc.dart
│   ├── auth_event.dart
│   └── auth_state.dart
└── widgets/                 # Feature-specific widgets
```

## State Management

### BLoC Pattern

We use **flutter_bloc** for predictable state management:

- **Events**: User actions or system triggers
- **States**: UI representations
- **BLoC**: Business logic and state transitions

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // Business logic
    emit(AuthSuccess());
  }
}
```

### Provider Pattern

Used for dependency injection and global state:

```dart
MultiProvider(
  providers: [
    Provider(create: (_) => RestClient()),
    BlocProvider(create: (_) => AuthBloc()),
  ],
  child: App(),
)
```

## Networking Layer

### Architecture

```
API ← Retrofit Client ← Dio ← Interceptors ← EnvConfig
```

### REST Client

Type-safe API clients generated with Retrofit:

```dart
@RestApi(baseUrl: '')
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio) = _AuthRestClient;

  @POST('/auth/login')
  Future<AuthModel> login(@Body() LoginRequest request);
}
```

### Request Flow

1. **EnvConfig** provides base URL and configuration
2. **Dio** handles HTTP requests with timeouts
3. **Interceptors** add JWT tokens, logging
4. **Retrofit** generates type-safe client code
5. **Models** with Freezed for immutability

### Error Handling

Centralized error handling with custom exceptions:

```dart
try {
  final response = await client.login(request);
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  }
}
```

## Data Models

### Freezed for Immutability

```dart
@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String accessToken,
    required String refreshToken,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
```

Benefits:
- Immutable data classes
- Copy-with functionality
- Union types for sealed classes
- JSON serialization

## Navigation

### Auto Route

Declarative routing with code generation:

```dart
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),
  ];
}
```

Features:
- Type-safe navigation
- Deep linking support
- Route guards for auth
- Nested navigation

## Configuration Management

### Environment-Based Config

```dart
class EnvConfig {
  final String apiBaseUrl;
  final bool debugMode;

  factory EnvConfig.fromEnvironment() {
    return EnvConfig(
      apiBaseUrl: const String.fromEnvironment('API_BASE_URL'),
      debugMode: const bool.fromEnvironment('DEBUG_MODE'),
    );
  }
}
```

### Build-Time Configuration

```bash
flutter build apk \
  --dart-define=API_BASE_URL=https://prod.api.com \
  --dart-define=DEBUG_MODE=false
```

## Storage Strategy

### Secure Storage

Sensitive data (tokens, user info):
```dart
final storage = FlutterSecureStorage();
await storage.write(key: 'access_token', value: token);
```

### Local Storage

App preferences and cache:
```dart
final box = GetStorage();
box.write('theme', 'dark');
```

## Localization

### Flutter Intl

Multi-language support:

```
assets/l10n/
├── intl_en.arb      # English
├── intl_ru.arb      # Russian
└── intl_kk.arb      # Kazakh
```

Usage:
```dart
Text(AppLocalizations.of(context).welcomeMessage)
```

## UI/UX Architecture

### Design System

Centralized theme in `mobile-shared`:

- **Typography**: BikeTypography with custom fonts
- **Colors**: Theme-aware color schemes
- **Icons**: Custom icon font (BikeIcons)
- **Components**: Reusable widgets (BikeButton, BikeTextField)

### Responsive Design

Using flutter_screenutil for adaptive layouts:

```dart
Container(
  width: 300.w,  // Responsive width
  height: 200.h, // Responsive height
)
```

## Code Generation

### Build Runner

Generates code for:
- Freezed models
- JSON serialization
- Retrofit clients
- Auto Route

```bash
melos run build  # One-time generation
melos run watch  # Continuous generation
```

## Testing Strategy

### Unit Tests

Test business logic and utilities:
```dart
test('AuthBloc emits success on valid login', () async {
  // Test implementation
});
```

### Widget Tests

Test UI components:
```dart
testWidgets('Login button triggers auth', (tester) async {
  // Widget test
});
```

### Integration Tests

End-to-end flows on real devices

## Performance Considerations

1. **Lazy Loading**: Route-based code splitting
2. **Image Optimization**: SVG for icons, optimized rasters
3. **List Performance**: ListView.builder for long lists
4. **State Management**: Minimal rebuilds with BLoC selectors
5. **Network Caching**: Dio interceptors for caching

## Security Architecture

### Authentication Flow

```
Login → JWT Token → Secure Storage → Dio Interceptor → API Requests
```

### Protected Routes

Route guards check authentication:
```dart
AutoRoute(
  page: ProfileRoute.page,
  guards: [AuthGuard()],
)
```

### API Security

- HTTPS only
- JWT token refresh logic
- Request/response encryption ready
- Certificate pinning support

## Deployment

### Build Variants

- **Development**: Debug logging, local API
- **Staging**: Testing on staging environment
- **Production**: Optimized, production API

### CI/CD Pipeline

1. Run tests
2. Code generation
3. Build apps
4. Deploy to stores

## Future Improvements

- [ ] Add integration tests
- [ ] Implement offline-first architecture
- [ ] Add analytics tracking
- [ ] Performance monitoring
- [ ] Crash reporting
- [ ] Feature flags system
