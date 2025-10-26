# Contributing Guidelines

## Development Workflow

### Branch Strategy

- `main` / `development`: Main development branch
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `hotfix/*`: Production hotfixes

### Commit Messages

Follow conventional commits:

```
feat: add payment integration
fix: resolve QR scanner crash on iOS
refactor: optimize map rendering
docs: update API documentation
style: format code with dart format
test: add auth bloc tests
```

### Pull Request Process

1. Create feature branch from `development`
2. Implement changes
3. Run code generation if needed
4. Write/update tests
5. Update documentation
6. Create PR with clear description
7. Address review comments
8. Squash and merge

## Code Style

### Dart Style Guide

Follow official Dart style guide:

```dart
// Good
class UserProfile {
  final String name;
  final int age;

  UserProfile({required this.name, required this.age});
}

// Bad
class user_profile {
  String Name;
  int Age;
}
```

### File Organization

```dart
// 1. Imports - dart, flutter, packages, local
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:app/core/utils.dart';

// 2. Class definition
class MyWidget extends StatelessWidget {
  // 3. Fields
  final String title;

  // 4. Constructor
  const MyWidget({super.key, required this.title});

  // 5. Methods
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Naming Conventions

- **Classes**: `PascalCase`
- **Variables**: `camelCase`
- **Constants**: `camelCase` (not SCREAMING_CASE)
- **Private**: `_leadingUnderscore`
- **Files**: `snake_case.dart`

## Architecture Guidelines

### BLoC Implementation

```dart
// Event
sealed class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String phone;
  LoginRequested(this.phone);
}

// State
sealed class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRestClient _client;

  AuthBloc(this._client) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _client.login(event.phone);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
```

### Widget Guidelines

- Keep widgets small and focused
- Extract reusable components to `mobile-shared`
- Use const constructors when possible
- Prefer composition over inheritance

```dart
// Good
class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildAvatar(),
          _buildName(),
        ],
      ),
    );
  }

  Widget _buildAvatar() => CircleAvatar();
  Widget _buildName() => Text('Name');
}
```

### State Management Rules

1. Use BLoC for complex business logic
2. Use Provider for dependency injection
3. Keep state close to where it's used
4. Avoid global state when possible

## API Integration

### Adding New Endpoints

1. Define model with Freezed:

```dart
@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required int id,
    required String name,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
}
```

2. Add to REST client:

```dart
@RestApi(baseUrl: '')
abstract class DeviceRestClient {
  @GET('/devices/{id}')
  Future<DeviceModel> getDevice(@Path() int id);
}
```

3. Run code generation:

```bash
melos run build
```

## Testing

### Unit Tests

Test business logic:

```dart
group('AuthBloc', () {
  test('emits loading then success on valid login', () async {
    final bloc = AuthBloc(mockClient);

    bloc.add(LoginRequested('1234567890'));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AuthLoading>(),
        isA<AuthSuccess>(),
      ]),
    );
  });
});
```

### Widget Tests

Test UI behavior:

```dart
testWidgets('Button triggers login', (tester) async {
  await tester.pumpWidget(MyApp());

  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();

  expect(find.text('Loading'), findsOneWidget);
});
```

## Shared Library Usage

### Adding to mobile-shared

Only add code that is:
- Used by multiple apps
- Truly generic and reusable
- Well documented

### Don't add to shared:
- App-specific business logic
- One-off components
- Tightly coupled code

## Performance Best Practices

1. **Build Method**: Keep it pure and fast
2. **Lists**: Use `ListView.builder` for long lists
3. **Images**: Use `CachedNetworkImage` for network images
4. **Animations**: Use `AnimatedBuilder` for complex animations
5. **Keys**: Use keys for stateful widgets in lists

## Security Checklist

- [ ] No hardcoded credentials
- [ ] Sensitive data in secure storage
- [ ] API keys from environment
- [ ] Input validation on all forms
- [ ] HTTPS only
- [ ] JWT token refresh logic

## Documentation

### Code Comments

Comment the why, not the what:

```dart
// Good
// Debounce search to prevent excessive API calls
Timer.debounce(() => search(), Duration(milliseconds: 500));

// Bad
// Create a timer
Timer.debounce(() => search(), Duration(milliseconds: 500));
```

### README Updates

Update README when adding:
- New features
- New dependencies
- New setup steps
- New environment variables

## Common Patterns

### Error Handling

```dart
try {
  final result = await api.call();
  return Success(result);
} on DioException catch (e) {
  return Failure(e.message);
} catch (e) {
  return Failure('Unknown error');
}
```

### Navigation

```dart
context.router.push(ProfileRoute(userId: id));
context.router.pop();
```

### Localization

```dart
Text(context.l10n.welcomeMessage)
```

## Dependencies

### Adding New Packages

1. Check if already exists in mono-repo
2. Add to appropriate pubspec.yaml
3. Run `melos bootstrap`
4. Document usage if non-obvious

### Version Management

- Use compatible versions: `^1.0.0`
- Lock breaking versions: `>=1.0.0 <2.0.0`
- Document reason for specific versions

## Questions?

Open an issue or discussion for:
- Architecture decisions
- New patterns
- Best practices
- Technical questions
