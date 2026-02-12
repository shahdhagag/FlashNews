
# 📰 FlashNews (news app)

**FlashNews (news app)** is a modern, high-performance Flutter news application that delivers real-time headlines from around the world.

Built with scalability, offline-first caching, and clean architecture principles, the app provides a seamless reading experience with multi-language support and a polished UI.

---

## ✨ Highlights

🌐 Real-time breaking news powered by **NewsAPI**  
📶 Offline-first support using **Hive Database**  
🔍 Smart debounced search experience  
🌍 Arabic 🇪🇬 & English 🇺🇸 Localization  
🌓 Light & Dark themes with custom splash screen  
⚡ Skeleton loading shimmer UI  
🔄 Pull-to-refresh for instant updates  
⚡ WebView support for full article browsing  
⚡ Built using BLoC + Clean Architecture  

---

## 🚀 Features

### 🌐 Real-time News
Fetch the latest headlines across multiple categories such as:

- Business  
- Sports  
- Technology  
- Health  
- Entertainment  
- Science  

Powered by **NewsAPI**.

---

### 📶 Offline Mode (Hive Powered)
The app caches loaded articles locally, allowing users to:

- Read news without internet  
- Browse saved categories  
- Search cached articles offline  

Offline mode follows:

> Remote-First → Local-Fallback Strategy

---

### 🔍 Smart Search
Search functionality includes:

- Debounced typing (no API spam)
- Search by title or content
- Works online + offline

---

### 🌍 Multi-language Support
Fully localized UI using **Easy Localization**:

- English (LTR)
- Arabic (RTL)

Layouts automatically adapt based on language.

---

### 🌓 Dynamic Theming
The application supports:

- Light Mode  
- Dark Mode  

Including a custom-designed splash screen for both.

---

### ⚡ Modern Responsive UI
Built with:

- **ScreenUtil** for adaptive scaling
- **Skeletonizer** for loading states
- **CachedNetworkImage** for optimized image rendering

---

### 🔄 Pull to Refresh
Users can update the feed instantly with a swipe gesture.

---

## 📸 Screenshots

### App Preview

<p align="center">
  <img src="https://github.com/user-attachments/assets/e72a2ef7-9c32-4287-9aac-bf200eb21066" width="230"/>
  <img src="https://github.com/user-attachments/assets/ae9a4564-f13c-442b-8529-5d9e83371f79" width="230"/>
  <img src="https://github.com/user-attachments/assets/62e540ab-f40f-4ea0-a219-8f08fb02514f" width="230"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/aa066513-b0bc-412f-bf31-92a862255b63" width="230"/>
  <img src="https://github.com/user-attachments/assets/1a8c86cb-eb44-4587-a74e-e2c075246243" width="230"/>
  <img src="https://github.com/user-attachments/assets/ef767a09-33b1-4c7f-8518-e71ba772bbea" width="230"/>
</p>


---

## 🛠 Tech Stack

| Category | Tools & Packages |
|---------|------------------|
| State Management | **BLoC / Cubit** |
| Dependency Injection | **Injectable + GetIt** |
| Networking | **Dio + Pretty Logger Interceptors** |
| Local Storage | **Hive + Hive Flutter** |
| Routing | **GoRouter** |
| Localization | **Easy Localization** |
| UI Enhancements | ScreenUtil, Skeletonizer, CachedNetworkImage |
| Offline Connectivity | connectivity_plus, internet_connection_checker |
| UX Tools | loader_overlay, pull_to_refresh |

---

## 📦 Dependencies Overview

Main packages used:

- `flutter_bloc`
- `dio`
- `hive`
- `injectable`
- `go_router`
- `easy_localization`
- `skeletonizer`
- `cached_network_image`

---

