//
//  HomeView.swift
//  CinemaVault
//
//  Created by Shreedharshan on 25/10/25.
//

import UIKit

class HomeView: UIView {
    
    var navBarView = UIView()
    
    var titleName = UILabel()
    
    var profileButton = UIButton()
    
    var searchView = UIView()
    var searchImage = UIImageView()
    var searchTextfield = UITextField()
    
    var moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var refreshControl = UIRefreshControl()
    
    var loader = UIActivityIndicatorView(style: .large)
    var placeholderImageView = UIImageView()
    
    var layoutDict = [String:Any]()
    
    func setupViews(_ baseView: UIView) {
        
        baseView.backgroundColor = .themeColor
        
        self.titleName.text = "Cinema Vault"
        self.titleName.textColor = .themeTxtColor
        self.titleName.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.titleName.textAlignment = .left
        self.titleName.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["titleName"] = titleName
        baseView.addSubview(self.titleName)
        
        profileButton.contentMode = .scaleAspectFit
        profileButton.backgroundColor = UIColor.secondaryColor.withAlphaComponent(0.2)
        profileButton.layer.cornerRadius = 20
        profileButton.clipsToBounds = true
        let image = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysTemplate)
        profileButton.imageView?.tintColor = .secondThemeColor
        profileButton.setImage(image, for: .normal)
        layoutDict["profileButton"] = profileButton
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(profileButton)
        
        self.searchView.layer.cornerRadius = 25
        self.searchView.layer.borderColor = UIColor.secondThemeColor.cgColor
        self.searchView.layer.borderWidth = 2
        self.searchView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["searchView"] = searchView
        baseView.addSubview(self.searchView)
        
        self.searchImage.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        self.searchImage.tintColor = .secondThemeColor
        self.searchImage.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["searchImage"] = searchImage
        searchView.addSubview(self.searchImage)
        
        searchTextfield.clearButtonMode = .whileEditing
        searchTextfield.placeholder = "Search Movies"
        searchTextfield.textColor = .themeTxtColor
        searchTextfield.textAlignment = .left
        searchTextfield.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        searchTextfield.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["searchTextfield"] = searchTextfield
        baseView.addSubview(searchTextfield)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        moviesCollectionView.backgroundColor = .themeColor
        moviesCollectionView.collectionViewLayout = collectionLayout
        layoutDict["moviesCollectionView"] = moviesCollectionView
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(moviesCollectionView)
        
        moviesCollectionView.refreshControl = refreshControl
        
        
        loader.color = .white
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(loader)
        
        placeholderImageView.image = UIImage(systemName: "film")
        placeholderImageView.tintColor = .lightGray
        placeholderImageView.contentMode = .scaleAspectFit
        placeholderImageView.isHidden = true
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(placeholderImageView)
        
        profileButton.centerYAnchor.constraint(equalTo: titleName.centerYAnchor).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: titleName.trailingAnchor, constant: -15).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.titleName.topAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleName]-15-|", options: [], metrics: [:], views: layoutDict))
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleName]-25-[searchView(50)]-25-[moviesCollectionView]", options: [.alignAllLeading,.alignAllTrailing], metrics: [:], views: layoutDict))
        
        searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 15).isActive = true
        searchImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        searchImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        searchImage.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        searchTextfield.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10).isActive = true
        searchTextfield.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10).isActive = true
        searchTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTextfield.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        moviesCollectionView.bottomAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        
        placeholderImageView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        placeholderImageView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        placeholderImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
}
