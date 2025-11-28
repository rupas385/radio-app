# 📻 Radio App - Labhouse Technical Test

A modern, robust, and efficient Flutter application that allows users to listen to live radio stations, manage favorites, and enjoy a seamless audio experience.

Developed as part of the technical assessment for the Flutter position (Option A).

## ✨ Features

* **Live Audio Streaming:** Robust background playback using `just_audio`.
* **Favorites System:** Local persistence using `shared_preferences` to save your top stations.
* **Reactive UI:** Real-time state management with **GetX** (Optimistic UI updates for favorites).
* **Search & Filter:** Smart filtering to show only favorite stations.
* **Polished UX:** Hero animations, Cached images with placeholders, and adaptive UI.
* **Architecture:** Clean Architecture principles with a pragmatic modular approach.

## 🛠 Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** GetX
* **Audio Engine:** just_audio + audio_service (Background support)
* **Networking:** http + cached_network_image
* **Persistence:** shared_preferences
* **API:** Radio Browser API (Free, open source)

## 🏗 Architecture

The project follows a **Scalable Folder Structure** organized by **Modules** (Features), creating a clear separation of concerns between UI, Business Logic, and Data.

I chose this structure to leverage **GetX's** full potential with Bindings and Controllers, ensuring the code is easy to navigate and scale.

### Directory Structure

* **`core/`**: Contains shared resources accessible by the entire app.
    * `services/`: Global services like `AudioPlayerService` and `ApiService`.
    * `themes/`: App visual styling.
* **`data/`**: Handling the data layer.
    * `models/`: Data classes with JSON serialization logic.
    * `providers/`: Data sources (API clients & Local Storage).
    * `repositories/`: The single source of truth that coordinates data from providers.
* **`modules/`**: Contains the features (e.g., `Home`). Each module is self-contained:
    * `binding/`: Dependency Injection setup for the module.
    * `controller/`: State management and business logic.
    * `views/`: UI implementation.

### Key Decisions

* **Repository Pattern:** Implemented in the `data` layer to abstract the data sources (API & SharedPreferences) from the UI/Controllers.
* **Service Pattern:** Used `GetxService` for the Audio Player to ensure background persistence and global access.
* **Pragmatic Approach:** For this specific time-constrained assignment, I opted to unify Entities and DTOs within the `models` folder to reduce boilerplate, while keeping the logic robust and testable.

## 🚀 How to Run

### Prerequisites
* Flutter SDK (Latest Stable)
* Dart SDK

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/rupas385/radio-app.git
    cd radio-app
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    * **iOS:** (Requires macOS)
        ```bash
        cd ios && pod install && cd ..
        flutter run
        ```
      *Note:* `NSAppTransportSecurity` has been configured in `Info.plist` to allow streaming from HTTP radio sources.

    * **Android:**
        ```bash
        flutter run
        ```
      *Note:* `usesCleartextTraffic` is enabled in `AndroidManifest.xml` to support legacy radio streams.

## ⏱ Time Log

* **Architecture Setup:** 1 hour
* **Core Logic (Audio Service & API):** 2 hours
* **UI & Animations:** 2 hours
* **Refactoring & Documentation:** 1 hour
* **Total:** ~ 6h hours

---
*Developed by Rubén Murcia Rocamora*