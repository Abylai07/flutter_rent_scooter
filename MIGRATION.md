# Migration Guide

## Package Rename: almabike → mobility_hub

The project has been renamed from "almabike" to "mobility_hub" for open-source sharing. This guide will help you update imports and references.

### Updated Package Names

- `almabike` → `mobility_hub`
- `almabike_app` → `mobility_hub_app`
- `almabike_admin` → `mobility_hub_admin`
- `almabike_shared` → `mobility_hub_shared`

### Required Changes

#### 1. Update Dependencies

After pulling these changes, run:

```bash
melos clean
melos bootstrap
melos run build
```

#### 2. Update Import Statements

Find and replace all import statements:

**Before:**
```dart
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
```

**After:**
```dart
import 'package:mobility_hub_shared/mobility_hub_shared.dart';
import 'package:mobility_hub_shared/core/utils/constants/bike_constants.dart';
```

#### 3. Update Main Library File

The shared library file has been renamed:

- `almabike_shared.dart` → `mobility_hub_shared.dart`

#### 4. Android Package Changes

Package ID changed:
- Old: `kz.almaty.almabike_app`
- New: `com.example.mobility_hub_app`

If you have existing builds, clean them:

```bash
cd apps/mobile-app/android
./gradlew clean
```

#### 5. iOS Bundle Identifier

If needed, update in Xcode:
- Product Bundle Identifier: `com.example.mobilityHubApp`

### Automated Migration Script

Use this command to update all imports:

```bash
find apps -name "*.dart" -type f -exec sed -i '' 's/package:almabike_shared/package:mobility_hub_shared/g' {} +
find apps -name "*.dart" -type f -exec sed -i '' 's/almabike_shared\.dart/mobility_hub_shared.dart/g' {} +
```

### New Features in This Update

1. **Environment Configuration System**
   - New `EnvConfig` class for managing API URLs and keys
   - Support for `--dart-define` build parameters
   - `.env.example` template for configuration

2. **Security Improvements**
   - Secrets moved to `.gitignore`
   - API keys via environment variables
   - Example files for sensitive data

3. **Documentation**
   - Comprehensive README
   - Architecture documentation
   - Contributing guidelines
   - Setup instructions

### Post-Migration Checklist

- [ ] Run `melos bootstrap`
- [ ] Run `melos run build`
- [ ] Update your local `.env` file
- [ ] Create `dgissdk.key` file if missing
- [ ] Test app builds on both platforms
- [ ] Update CI/CD scripts if any
- [ ] Update deployment configurations

### Troubleshooting

**Build errors after migration:**
```bash
melos clean
rm -rf apps/*/ios/Pods
rm -rf apps/*/ios/Podfile.lock
melos bootstrap
melos run build
```

**Import errors:**
Make sure all imports are updated:
```bash
grep -r "almabike_shared" apps/
```

Should return no results after migration.

### Need Help?

Open an issue if you encounter problems during migration.
