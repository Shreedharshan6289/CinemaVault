# 🎬 CinemaVault

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
