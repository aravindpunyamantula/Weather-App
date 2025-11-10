# 🌦️ Weather App

A modern **Flutter-based weather application** that provides **real-time weather updates** using your **live location** or any **searched city**.  
The app offers an elegant, dynamic UI that changes according to the **time of day** and **current weather conditions**, ensuring an engaging and informative experience.

---

## 📋 Table of Contents
- [✨ Features](#-features)
- [📱 Screenshots](#-screenshots)
- [🧩 Architecture Overview](#-architecture-overview)
- [⚙️ Installation](#️-installation)
- [🚀 Usage](#-usage)
- [🧠 Dependencies](#-dependencies)
- [⚡ Configuration](#-configuration)
- [💡 Example .env File](#-example-env-file)
- [🛠️ Troubleshooting](#️-troubleshooting)
- [👨‍💻 Author](#-author)
- [📄 License](#-license)

---

## ✨ Features
- 🌍 **Live Location Weather:** Automatically fetches real-time weather based on your current location.  
- 🔍 **Search by City:** Get weather details for any location worldwide.  
- ⏰ **Hourly & Daily Forecast:** Displays detailed hourly and daily forecasts.  
- 🎨 **Dynamic Themes:** Background and UI colors adapt dynamically to weather and time (day/night).  
- 📊 **Clean Architecture:** Organized using repository and use-case layers for scalability.  
- 🌐 **Cross-Platform Support:** Works on **Android** and **Web**.

---

## 📱 Screenshots

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/76f7d1eb-4db4-4950-8790-8952f620e648" alt="Weather App Screenshot 1"/>
  <img width="250" src="https://github.com/user-attachments/assets/917f9be1-27a9-40b9-806b-7b430bb9d67e" alt="Weather App Screenshot 2"/>
  <img width="250" src="https://github.com/user-attachments/assets/b36e9faf-9dd1-4c24-8f35-ed3f113f9675" alt="Weather App Screenshot 3"/>
  <img width="250" src="https://github.com/user-attachments/assets/e8c6cae5-7b9f-401a-92c2-0ade412cb286" alt="Weather App Screenshot 4"/>
</p>

---

## 🧩 Architecture Overview

This project follows a **Clean Architecture + Provider** state management pattern:

- **Data Layer:** Handles API fetching and local data storage using **Hive**.  
- **Domain Layer:** Contains business logic and use cases (e.g., `FetchCurrentWeatherUsecase`).  
- **Presentation Layer:** Includes UI screens, widgets, and Providers for state management.

---

## ⚙️ Installation

### 1. Clone the repository
```bash
git clone https://github.com/aravindpunyamantula/Weather-App.git
cd Weather-App
```


2. Install dependencies
```bash
flutter pub get
```

4. Set up environment variables

Create a .env file in the project root:
```bash
touch .env
```

Then add your weather API credentials.

4. Run the app

For Android:
```bash
flutter run
```

For Web:
```bash
flutter run -d chrome
```

## 🚀 Usage
On launch, the app requests your location to fetch current weather.

You can manually search for other cities.

The app displays current, hourly, and daily forecasts with dynamic UI themes.

## 🧠 Dependencies
Package	Description
flutter_dotenv	Loads environment variables securely from .env.
http	Handles REST API calls to fetch weather data.
provider	State management for UI and logic.
geolocator	Retrieves live device location.
hive_flutter	Local data caching and persistence.
device_preview	Allows testing UI responsiveness across devices.
intl	Formats date and time for forecasts.
iconsax	Provides rich iconography for UI.

## ⚡ Configuration
Add your Weather API base URL and API key to the .env file.

💡 Example .env File
BASE_URL=https://api.openweathermap.org/data/2.5
API_KEY=your_api_key_here

## 🛠️ Troubleshooting
Issue	Solution
Location not fetched	Ensure GPS permission is granted in device settings.
API errors	Check that your .env file has a valid API key and URL.
App crashes on start	Run flutter clean then flutter pub get and restart.
Web build not loading weather	Verify browser location permissions and HTTPS API usage.

## 👨‍💻 Author
# Developed by: [Aravind Punyamantula](https://github.com/aravindpunyamantula)

A Flutter enthusiast passionate about clean architecture and beautiful UI design.

## 📄 License

This project is licensed under the MIT License.
