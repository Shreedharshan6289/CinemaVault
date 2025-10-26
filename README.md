<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 32 09" src="https://github.com/user-attachments/assets/393d9504-ce77-492e-a622-3f242338616d" /># 🎬 CinemaVault

**CinemaVault** is an iOS app that lets you explore popular movies, view detailed information, watch trailers, search for movies, and manage your favorites.  
Built with **Swift**, **UIKit**, and **Alamofire**, integrating **The Movie Database (TMDb) API**.

---

## Features

### 🏠 Home / Movies List
- Displays popular movies with:
  - Poster
  - Title
  - Released Year
  - Rating
- Supports searching movies by title.

### 🎥 Movie Detail Page
- Shows detailed movie information:
  - Title, Plot, Genre(s), Cast, Duration, Rating
  - Trailer playback (YouTube embedded)
- Mark/unmark movies as favorites.

### ⭐ Favorites
- Favorite/unfavorite movies from detail pages.
- Favorites persist across app launches using `UserDefaults`.

---

## Known Issues
- YouTube video player is not fully optimized on all devices (occasional autoplay restrictions).

---

## Dependencies
- [Alamofire](https://github.com/Alamofire/Alamofire) – Networking library

---

## Setup

1. **Clone the repository**
   
```bash
git clone https://github.com/yourusername/CinemaVault.git
cd CinemaVault
```

2. **Install dependencies**
Alamofire is required. Use Swift Package Manager to install.

3. **TMDb API Key**
- Obtain an API key from TMDb.
- Open LocalDB.swift and set your API key:

```swift
      static let apikey = "YOUR_TMDB_API_KEY"
```

4. **Build and Run**
- Open CinemaVault.xcodeproj in Xcode.
- Select a simulator or real device.
- Run the app.


## API Endpoints Used

- Popular Movies: https://api.themoviedb.org/3/movie/popular
- Movie Details: https://api.themoviedb.org/3/movie/{movie_id}
- Movie Trailers: https://api.themoviedb.org/3/movie/{movie_id}/videos
- Movie Search: https://api.themoviedb.org/3/search/movie

## Screenshots

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 31 40" src="https://github.com/user-attachments/assets/a41d60a0-10a7-44a9-b2d2-792598c89529" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 31 56" src="https://github.com/user-attachments/assets/6ff3fb03-e282-4e28-ae35-3ce0c6bdfcc1" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 32 09" src="https://github.com/user-attachments/assets/0884f353-ae62-4bfc-a7e3-d2b9b791d3aa" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 33 25" src="https://github.com/user-attachments/assets/cd043479-333c-4e06-bfaa-ee804ecebb64" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 35 02" src="https://github.com/user-attachments/assets/784ee445-33a7-4035-857c-1696af7fee05" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2025-10-26 at 11 32 42" src="https://github.com/user-attachments/assets/370a09ea-1bbd-4144-95dc-de0a1c8ec7c9" />

