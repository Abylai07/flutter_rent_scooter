# ScooterShare

> Production-ready electric scooter sharing platform • Advanced BLoC architecture • Real-time tracking • Fleet management

A professional Flutter mono-repo demonstrating senior-level mobile development: complex state management, algorithmic optimizations (TSP, Haversine), payment processing, and scalable architecture.

## 📦 What's Inside

```
mono-repo/
├── mobile-app/      # User app: rent, ride, pay
├── mobile-admin/    # Tech app: fleet, diagnostics, battery swap
└── mobile-shared/   # 40%+ shared code
```

## ⚡ Key Features

**User App**
- 🚴 Real-time ride tracking (5s GPS updates, Haversine distance)
- 🗺️ Interactive map with filters (battery, distance, price)
- 💳 Multi-payment (Cards, Apple/Google Pay, Wallet)
- 🎁 Loyalty system (10 pts/$1) + Promo codes
- 🔐 Biometric auth + PIN protection

**Admin App**
- 📊 Fleet dashboard (30+ scooters, real-time stats)
- 🔋 Battery swap workflow (QR scan, health validation, timer)
- 🛠️ Diagnostics system (5 automated tests)
- 🧭 Route optimization (TSP algorithm)
- 📍 Priority-based sorting (urgency × proximity)

## 🛠️ Tech Stack

```yaml
Flutter: 3.6+  |  Dart: 3.6+  |  Melos: Mono-repo
```

**Core**
- **State**: BLoC (6 complex blocs, 50+ events, 15+ states)
- **Network**: Dio + Retrofit (type-safe, interceptors)
- **Navigation**: Auto Route (deep links)
- **Storage**: Secure Storage + GetStorage
- **Maps**: 2GIS SDK

**Code Gen**
- Freezed (immutable models)
- json_serializable
- build_runner

## 🧠 Architecture Highlights

**RideSessionBloc** - 200 lines, dual timers
```dart
Manages: GPS tracking (5s) • Distance (Haversine) • Cost calc
         Pause/Resume • Limit checks • Route recording
```

**ScooterMapBloc** - 180 lines, multi-filter
```dart
Features: Search • Filter • Sort by distance • Reservations
          Auto-refresh (30s) • Favorites
```

**FleetMapBloc** - 250 lines, TSP optimization
```dart
Handles: Fleet stats • Priority sorting • Route planning
         Task correlation • Multi-status filters
```

**PaymentBloc** - 220 lines, transaction ledger
```dart
Supports: Multi-payment • Wallet • Bonuses • Promos
          Loyalty (10pts/$1) • History
```

**BatterySwapBloc** - 180 lines, step-by-step
```dart
Process: QR scan → Health check → Swap timer → Record
```

**DiagnosticsBloc** - 200 lines, 5-test suite
```dart
Tests: System • Motor • Brakes • Lights • Connectivity
```

## 📂 Structure

```
mobile-app/
├── features/
│   ├── ride/          → RideSessionBloc (GPS, timers)
│   ├── scooter_map/   → ScooterMapBloc (search, filter)
│   └── payment/       → PaymentBloc (wallet, transactions)

mobile-admin/
├── features/
│   ├── fleet_map/     → FleetMapBloc (TSP, stats)
│   ├── battery_swap/  → BatterySwapBloc (QR, validation)
│   └── diagnostics/   → DiagnosticsBloc (5 tests)

mobile-shared/
├── models/            → Freezed data classes
├── config/            → EnvConfig (dart-define)
├── networking/        → Retrofit clients
└── widgets/           → Reusable UI
```

## 🚀 Quick Start

```bash
# 1. Setup
dart pub global activate melos
melos bootstrap

# 2. Configure
cp .env.example .env
echo "your_2gis_key" > apps/mobile-app/assets/dgissdk.key

# 3. Generate
melos run build

# 4. Run
cd apps/mobile-app
flutter run --dart-define=API_BASE_URL=https://api.example.com/
```

**Full guide**: [SETUP.md](SETUP.md)

## 💻 Development

**Melos scripts**:
```bash
melos run build    # Generate code (Freezed, Retrofit)
melos run watch    # Watch mode
melos run clean    # Clean all
```

**Environment config**:
```dart
EnvConfig.fromEnvironment()  // Reads --dart-define
```

**Build with env**:
```bash
flutter build apk \
  --dart-define=API_BASE_URL=$PROD_URL \
  --dart-define=MAP_API_KEY=$KEY
```

## 🔧 Admin App Deep Dive

**Fleet Map** (400 lines)
- Real-time stats: 6 KPIs (total, available, in-use, maintenance, offline, avg battery)
- TSP route optimizer (greedy nearest-neighbor)
- Priority scoring: `urgency × proximity`
- Draggable detail sheets

**Battery Swap** (350 lines)
- QR scanner → Health validation (charge ≥80%, cycles, temp)
- 3-step workflow: Remove → Install → Test
- Live timer with progress
- GPS-stamped records

**Diagnostics** (200 lines)
- Sequential tests: System → Motor → Brakes → Lights → Connectivity
- Pass/Warning/Fail with recommendations
- Progress tracking (0-100%)

**Maintenance Tasks**
- 8 types × 4 priorities
- Location-based assignment
- Status: Pending → Assigned → In Progress → Completed

## 🔐 Security

- EnvConfig (no hardcoded secrets)
- JWT auth + refresh
- Secure Storage (encrypted)
- Biometric + PIN
- `.gitignore` for all keys

## 📚 Documentation

- [SETUP.md](SETUP.md) - Full setup guide
- [ARCHITECTURE.md](ARCHITECTURE.md) - Design decisions
- [CONTRIBUTING.md](CONTRIBUTING.md) - Code standards
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Technical overview

## 📊 Stats

```
6 BLoCs  •  50+ Events  •  15+ States
10K+ lines Dart  •  40%+ code reuse
```

**Demonstrates**:
✅ Advanced BLoC patterns (timers, streams, complex logic)
✅ Algorithms (Haversine, TSP, priority scoring)
✅ Production patterns (env config, error handling, testing-ready)
✅ Scalable architecture (mono-repo, DI, clean separation)

---

**License**: MIT
**Docs**: See individual README files in each app
