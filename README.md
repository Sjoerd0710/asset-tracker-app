# Asset Tracker App

A Flutter app for high-net-worth individuals to track and manage their valuable assets including cars, boats, planes, properties, and more.

## Features

- 📱 **Cross-Platform**: iOS and Android support
- 🔐 **Secure Authentication**: Email/password sign-up and login
- 💰 **Asset Management**: Add and manage multiple assets
- 📊 **Portfolio Overview**: View total portfolio value at a glance
- 🔧 **Maintenance Tracking**: Schedule and log maintenance for each asset
- 📈 **Valuation History**: Track asset valuations over time
- 📸 **Photo Support**: Add photos of your assets
- 📱 **Real-time Updates**: Synced across devices with Firestore

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase (Auth, Firestore, Storage)
- **State Management**: Provider + Riverpod
- **Database**: Cloud Firestore

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase project set up
- Xcode (for iOS)
- Android Studio (for Android)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Sjoerd0710/asset-tracker-app.git
cd asset-tracker-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
```bash
flutterfire configure
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── models/
│   ├── asset.dart
│   ├── maintenance.dart
│   └── valuation.dart
├── services/
│   ├── auth_service.dart
│   └── asset_service.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   └── assets/
│       ├── add_asset_screen.dart
│       └── asset_detail_screen.dart
└── routes/
    └── router.dart
```

## Next Steps

- [ ] Complete Firebase configuration
- [ ] Implement asset detail view
- [ ] Add maintenance scheduling UI
- [ ] Implement valuation tracking
- [ ] Add image upload functionality
- [ ] Implement push notifications for maintenance reminders
- [ ] Add export/reporting features
- [ ] Implement dark mode
- [ ] Add multi-language support

## License

MIT
