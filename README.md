# Spendlog

Spendlog is a Flutter app for keeping a private record of daily spending on your phone. Amounts are stored in paisa so totals do not drift, and nothing leaves the device.

## Run

```bash
flutter pub get
flutter test
flutter run
```

If the Android or iOS tooling is incomplete on a fresh checkout, run `flutter create . --project-name spendlog` in this folder. That fills in platform files and leaves `lib/` and `test/` in place.

## What's inside

- A month total with a category breakdown
- Add, edit, and delete an expense
- History grouped by day
- An example month you can load from Settings

Amounts use Pakistani rupees. `Rs 250.50` is stored as `25050` minor units.
