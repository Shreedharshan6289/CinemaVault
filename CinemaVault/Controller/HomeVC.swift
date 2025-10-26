//
//  HomeVC.swift
//  CinemaVault
//
//  Created by Shreedharshan on 25/10/25.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    var homeView = HomeView()
    var movies: [Movie] = []
    var originalMovies: [Movie] = []
    var currentPage = 1
    var isLoading = false
    var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupButtons()
        getMoviesList()
        setupSearch()
        setupPullToRefresh()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshMovies()
    }
    
    func setupViews() {
        self.homeView.setupViews(self.view)
        
    }
    
    func setupCollectionView() {
        self.homeView.moviesCollectionView.delegate = self
        self.homeView.moviesCollectionView.dataSource = self
        self.homeView.moviesCollectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
    func setupButtons() {
        self.homeView.profileButton.addTarget(self, action: #selector(profileButtonAction(_ :)), for: .touchUpInside)
    }
    
    func setupPullToRefresh() {
        homeView.refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
    }
    
    func setupSearch() {
        homeView.searchTextfield.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
}

// MARK: OBJC FUNCTIONNS

extension HomeVC {
    
    @objc func profileButtonAction(_ sender: UIButton) {
        let vc = ProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshMovies() {
        currentPage = 1
        movies.removeAll()
        getMoviesList()
    }
    
    @objc func searchTextChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.isEmpty {
            // Show original popular movies
            movies = originalMovies
            homeView.moviesCollectionView.reloadData()
        } else {
            searchMovies(query: text)
        }
    }
    
}

// MARK: CollectionView

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell ?? MoviesCollectionViewCell()
        let movie = movies[indexPath.item]

        // Title
        cell.movieTitle.text = movie.title ?? "Untitled"

        // Rating
        if let rating = movie.rating {
            cell.ratingsLabel.text = String(format: "⭐ %.1f", rating)
        } else {
            cell.ratingsLabel.text = "⭐ N/A"
        }

        // Release year
        if let release = movie.releaseDate, !release.isEmpty {
            let year = release.split(separator: "-").first
            cell.durationLabel.text = year.map { String($0) } ?? release
        } else {
            cell.durationLabel.text = "Unknown"
        }

        // Poster image
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    DispatchQueue.main.async {
                        cell.posterImageView.image = data.flatMap { UIImage(data: $0) } ?? UIImage(named: "placeholder")
                    }
                }.resume()
            } else {
                cell.posterImageView.image = UIImage(named: "placeholder")
            }
        } else {
            cell.posterImageView.image = UIImage(named: "placeholder")
        }

        // Favourite star
        if let movieID = Int(movie.id ?? "") {
            cell.favouriteIcon.isHidden = !FavouritesManager.shared.isFavourite(movieID: movieID)
        }

        // Pagination
        if indexPath.item == movies.count - 1 && !isLoading && currentPage < totalPages {
            currentPage += 1
            getMoviesList()
        }

        return cell
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsVC()
        vc.movieID = movies[indexPath.item].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.1, height: 300)
    }
    
    
}

// MARK: API & Pagination

extension HomeVC {
    
    func getMoviesList() {
        guard !isLoading else { return }
        isLoading = true
        homeView.loader.startAnimating()
        homeView.placeholderImageView.isHidden = true
        
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(LocalDB.apikey)&page=\(currentPage)"
        
        AF.request(url, method: .get).responseJSON { response in
            self.isLoading = false
            self.homeView.loader.stopAnimating()
            self.homeView.refreshControl.endRefreshing()
            
            switch response.result {
            case .success(let value):
                guard let result = value as? [String: AnyObject] else { return }
                
                if let totalPages = result["total_pages"] as? Int {
                    self.totalPages = totalPages
                }
                
                if let results = result["results"] as? [[String: AnyObject]] {
                    let moviesList = results.compactMap({ Movie($0) })
                    
                    if self.currentPage == 1 {
                        self.movies = moviesList
                        self.originalMovies = moviesList
                    } else {
                        self.movies.append(contentsOf: moviesList)
                    }
                    
                    DispatchQueue.main.async {
                        self.homeView.moviesCollectionView.reloadData()
                        self.homeView.placeholderImageView.isHidden = !self.movies.isEmpty
                    }
                }
                
            case .failure(let error):
                print("Error fetching movies:", error.localizedDescription)
                if self.movies.isEmpty {
                    self.homeView.placeholderImageView.isHidden = false
                }
            }
        }
    }
    
    func searchMovies(query: String) {
        guard !isLoading else { return }
        isLoading = true
        homeView.loader.startAnimating()
        homeView.placeholderImageView.isHidden = true
        
        let queryEscaped = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(LocalDB.apikey)&query=\(queryEscaped)&page=1"
        
        AF.request(url, method: .get).responseJSON { response in
            self.isLoading = false
            self.homeView.loader.stopAnimating()
            
            switch response.result {
            case .success(let value):
                guard let result = value as? [String: AnyObject] else { return }
                print(result)
                
                if let results = result["results"] as? [[String: AnyObject]] {
                    self.movies = results.compactMap({ Movie($0) })
                    
                    DispatchQueue.main.async {
                        self.homeView.moviesCollectionView.reloadData()
                        self.homeView.placeholderImageView.isHidden = !self.movies.isEmpty
                    }
                }
                
            case .failure(let error):
                print("Search Error:", error.localizedDescription)
                DispatchQueue.main.async {
                    self.homeView.placeholderImageView.isHidden = !self.movies.isEmpty
                }
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100, currentPage < totalPages, !isLoading {
            currentPage += 1
            if homeView.searchTextfield.text?.isEmpty ?? true {
                getMoviesList()
            } else {
                searchMovies(query: homeView.searchTextfield.text ?? "")
            }
        }
    }
    
}
