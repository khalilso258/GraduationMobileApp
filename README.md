# Syriatel

A Flutter application built for Syriatel Telecom in Syria to deliver personalized upselling offers and usage-based package recommendations.

## 🚀 What This App Does

The Syriatel app is a customer-facing telecom portal with a focus on:
- Personalized package suggestions using customer usage history
- Machine learning-driven upsell offers for voice, SMS, and data bundles
- Custom package generation and activation
- Access to currently activated packages and profile usage analytics

The mobile app integrates with backend APIs to display AI-powered package recommendations that are tailored to each subscriber’s historical behavior.

## ⚙️ Core Capabilities

- User authentication with login and secure token storage
- Profile and monthly usage retrieval
- Suggested packages fetched from `suggested-packages/`
- Activation of accepted offers and custom clusters via backend endpoints
- Display of activated packages, offer details, and usage breakdown
- Responsive UI built with GetX state management and GetPage navigation

## 🧠 ML & Upselling Flow

This project is intended for an upselling use case where Syriatel can:
- analyze customer usage trends
- recommend the most relevant packages
- present offers with call, message, and internet usage details
- enable package acceptance and activation directly inside the app

Most of the machine learning logic lives on the backend; the app consumes the recommended package list and renders it as user-facing offers.

## 🧱 Tech Stack

- Flutter 3.x
- Dart 3.x
- GetX for state management, routing, and dependency injection
- shared_preferences for local token persistence
- fl_chart and syncfusion_flutter_charts for usage analytics UI
- smooth_page_indicator and percent_indicator for polished UI widgets
- google_fonts for custom typography

## 📂 Repository Structure

- `lib/main.dart` — app entry point and auth-based routing
- `lib/auth/api_service.dart` — API client for login, profile, offers, and package activation
- `lib/controllers/` — GetX controllers for login, profile, offers, activated packages, and custom package creation
- `lib/models/` — domain models such as offers, activated packages, profile usage, and custom package payloads
- `lib/view/` — screen implementations for login, main dashboard, profile, offers, and package dialogs
- `lib/services/` — app services including storage and token validation
- `lib/theme/` — app theme, color palette, and responsive sizing utilities

## ✅ Setup & Run

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd syriatel/syriatel
   ```
2. Install Flutter dependencies
   ```bash
   flutter pub get
   ```
3. Run the app on a connected device or emulator
   ```bash
   flutter run
   ```

## 🔧 Configuration Notes

- The app uses a private Flutter package configuration (`publish_to: none`).
- Backend endpoints are configured in `lib/auth/api_service.dart` and may need adjustment for the target API environment.
- Ensure Flutter SDK, Android/iOS tooling, and device/emulator support are installed before running.

## 📌 Important Project Details

- Upselling is driven by packages recommended via backend ML models
- `OfferModel` includes suggested call, message, and internet bundles
- Users can accept packages using `ApiService.acceptPackage`
- Custom package activation is handled by `ApiService.activateClusterPackage`
