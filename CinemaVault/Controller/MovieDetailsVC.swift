//
//  MovieDetailsVC.swift
//  CinemaVault
//
//  Created by Apple on 25/10/25.
//

import UIKit
import AVKit
import Alamofire


class MovieDetailsVC: UIViewController {
    
    var movieDetailsView = MovieDetailsView()
    var movieID = ""
    
    var trailerURL: String?
    var castMembers: [CastMember] = []
    
    private var loadingCount = 0 {
        didSet { updateLoader() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView.setupViews(self.view)
        setupActions()
        
        fetchMovieDetails()
        fetchMovieVideos()
        fetchMovieCast()
    }
    
    // MARK: - Actions
    func setupActions() {
        movieDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        movieDetailsView.playButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
        movieDetailsView.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favouriteButtonTapped(_ sender: UIButton) {
        guard let movieIDInt = Int(movieID) else { return }
        
        if sender.isSelected {
            sender.isSelected = false
            FavouritesManager.shared.removeFavourite(movieID: movieIDInt)
        } else {
            sender.isSelected = true
            FavouritesManager.shared.addFavourite(movieID: movieIDInt)
        }
    }
    
    @objc func playTrailer() {
        guard let trailerKey = extractYouTubeKey(from: trailerURL) else { return }
        let vc = TrailerFullScreenVC(trailerKey: trailerKey)
        present(vc, animated: true)
    }

    // Helper function (same as before)
    func extractYouTubeKey(from urlString: String?) -> String? {
        guard let urlString = urlString else { return nil }
        if let url = URL(string: urlString), let host = url.host, host.contains("youtube.com") || host.contains("youtu.be") {
            if host.contains("youtu.be") {
                return url.lastPathComponent
            } else if let queryItems = URLComponents(string: urlString)?.queryItems {
                return queryItems.first(where: { $0.name == "v" })?.value
            }
        }
        return nil
    }

    
    
    
    // MARK: - Loader handling
    private func updateLoader() {
        DispatchQueue.main.async {
            if self.loadingCount > 0 {
                self.movieDetailsView.loader.startAnimating()
            } else {
                self.movieDetailsView.loader.stopAnimating()
            }
        }
    }
}

// MARK: - UI Update
extension MovieDetailsVC {
    
    private func updateMovieDetailsUI(_ movie: MovieDetails) {
        movieDetailsView.movieTitleLabel.text = movie.title
        
        // Favourites button state
        if let id = Int(movieID) {
            movieDetailsView.favouriteButton.isSelected = FavouritesManager.shared.isFavourite(movieID: id)
        }
        
        movieDetailsView.ratingsLabel.text = String(format: "⭐ %.1f", movie.voteAverage ?? 0.0)
        movieDetailsView.durationLabel.text = movie.runtime != nil ? "\(movie.runtime!) min" : "-"
        movieDetailsView.genreLabel.text = "   " + movie.genres.joined(separator: ", ")
        movieDetailsView.plotLabel.text = movie.overview
        
        // Poster image
        if let poster = movie.posterPath, let url = URL(string: poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.movieDetailsView.trailerThumbnail.image = img
                    }
                }
            }
        }
    }
    
    private func updateTrailerUI(_ youtubeKey: String?) {
        guard let key = youtubeKey else {
            movieDetailsView.playButton.isHidden = true
            return
        }
        // Build YouTube URL
        trailerURL = "https://www.youtube.com/watch?v=\(key)"
        movieDetailsView.playButton.isHidden = false
    }
    
    private func updateCastUI(_ cast: [CastMember]) {
        self.castMembers = cast
        movieDetailsView.updateCastUI(cast)
    }
}

// MARK: - API Calls
extension MovieDetailsVC {
    
    private func fetchMovieDetails() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(LocalDB.apikey)&language=en-US") else { return }
        loadingCount += 1
        
        AF.request(url).responseJSON { response in
            self.loadingCount -= 1
            
            switch response.result {
            case .success(let value):
                if let dict = value as? [String: AnyObject] {
                    let movie = MovieDetails(dict)
                    DispatchQueue.main.async {
                        self.updateMovieDetailsUI(movie)
                    }
                }
            case .failure(let error):
                print("Movie details error:", error.localizedDescription)
            }
        }
    }
    
    private func fetchMovieVideos() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(LocalDB.apikey)&language=en-US") else { return }
        loadingCount += 1
        
        AF.request(url).responseJSON { response in
            self.loadingCount -= 1
            
            switch response.result {
            case .success(let value):
                if let dict = value as? [String: Any],
                   let results = dict["results"] as? [[String: AnyObject]] {
                    let trailers = results.compactMap { MovieVideo($0) }
                        .filter { $0.type?.lowercased() == "trailer" && $0.site?.lowercased() == "youtube" }
                    self.updateTrailerUI(trailers.first?.key)
                    print(trailers)
                }
            case .failure(let error):
                print("Video fetch error:", error.localizedDescription)
            }
        }
    }
    
    private func fetchMovieCast() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(LocalDB.apikey)&language=en-US") else { return }
        loadingCount += 1
        
        AF.request(url).responseJSON { response in
            self.loadingCount -= 1
            
            switch response.result {
            case .success(let value):
                if let dict = value as? [String: Any], let castArr = dict["cast"] as? [[String: AnyObject]] {
                    let cast = castArr.compactMap { CastMember($0) }
                    DispatchQueue.main.async {
                        self.updateCastUI(cast)
                    }
                }
            case .failure(let error):
                print("Cast fetch error:", error.localizedDescription)
            }
        }
    }
}
