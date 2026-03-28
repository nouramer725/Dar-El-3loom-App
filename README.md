# Dar El 3loom 📱

A modern Flutter mobile application designed to support multiple user roles (Student, Parent, Teacher, Assistant) with a smooth, scalable, and user-friendly experience.

---

## 🚀 Overview

**Dar El 3loom** is a cross-platform mobile application built using Flutter.
The app provides different experiences based on user roles, integrates with backend services, and supports real-time communication.

---

## ✨ Features

* 👨‍👩‍👧 Multi-role system (Parent, Teacher, Assistant)
* 🎨 Clean and responsive UI
* 🔐 Authentication system
* 🌐 API integration using Dio
* 🔄 Real-time communication using Socket.IO
* 💾 Local storage using Hive & SharedPreferences
* 📶 Internet connectivity handling
* 🧠 State management using Provider
* 🖼️ Image picker & gallery saver
* 🔔 User feedback with Toast messages
* 🚀 Splash screen & onboarding

---

## 🛠️ Tech Stack

* **Flutter & Dart**
* **Provider** (State Management)
* **Dio** (Networking)
* **Hive** (Local Database)
* **Socket.IO Client**
* **Shared Preferences**
* **Flutter Dotenv**
* **Connectivity Plus**

---

## 📂 Project Structure

```plaintext
lib/
│── backend_setup/     # Backend configuration & setup
│
│── home/                  # Student home screen
│── home_assistant/        # Assistant features
│── home_parent/           # Parent features
│── home_teacher/          # Teacher features
│
│── auth/                 # Authentication
│
│── models/                 # Data models
│
│── provider/              # State management
│
│── socket/                # Real-time features
│
│── utils/                 # Helpers & utilities
│
│── widgets/               # Reusable components
│
│── main.dart              # Entry point
```

---

## ⚙️ Getting Started

### 1. Clone the project

```bash
git clone https://github.com/nouramer725/Dar-El-3loom-App.git
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Setup environment variables

Create a `.env` file in the root directory:

```env
BASE_URL=https://api.yourserver.com
API_KEY=your_api_key
```

---

### 4. Run the app

```bash
flutter run
```

---

## 📦 Build Release

### Android

```bash
flutter build appbundle
```

### iOS

```bash
flutter build ios
```

---

## 🧑‍💻 Author

Developed by **Nour Muhammed Mahmoud**

---

## 📄 Notes

* This project is structured for scalability and supports multiple user roles.
* Make sure to configure the `.env` file before running the app.
* Some features depend on backend availability.

---
