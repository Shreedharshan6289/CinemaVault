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
