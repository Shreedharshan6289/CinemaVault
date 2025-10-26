//
//  MoviesCollectionViewCell.swift
//  CinemaVault
//
//  Created by Apple on 25/10/25.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    var  movieView = UIView()
    
    var posterImageView = UIImageView()
    var movieTitle = UILabel()
    
    var ratingsView = UIView()
    var ratingsLabel = UILabel()
    
    var durationLabel = UILabel()
    
    var favouriteIcon = UIImageView()
    
    var layoutDict = [String: Any]()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupViews()
    }
    
    func setupViews() {
        
        contentView.isUserInteractionEnabled = true
        
        self.backgroundColor = .themeColor
        
        movieView.layer.borderWidth = 2
        movieView.layer.borderColor = UIColor.secondThemeColor.cgColor
        movieView.layer.cornerRadius = 10
        movieView.clipsToBounds = true
        layoutDict["movieView"] = movieView
        movieView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieView)
        
        posterImageView.backgroundColor = .black.withAlphaComponent(0.5)
        posterImageView.contentMode = .scaleAspectFit
        layoutDict["posterImageView"] = posterImageView
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        movieView.addSubview(posterImageView)
        
        movieTitle.textColor = .themeTxtColor
        movieTitle.numberOfLines = 2
        movieTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        movieTitle.textAlignment = .left
        layoutDict["movieTitle"] = movieTitle
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieView.addSubview(movieTitle)
        
        layoutDict["ratingsView"] = ratingsView
        ratingsView.translatesAutoresizingMaskIntoConstraints = false
        movieView.addSubview(ratingsView)
        
        ratingsLabel.textColor = .themeTxtColor
        ratingsLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        ratingsLabel.textAlignment = .left
        layoutDict["ratingsLabel"] = ratingsLabel
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsView.addSubview(ratingsLabel)
        
        durationLabel.textColor = .themeTxtColor
        durationLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        durationLabel.textAlignment = .right
        layoutDict["durationLabel"] = durationLabel
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        movieView.addSubview(durationLabel)
        
        favouriteIcon.image = UIImage(systemName: "star.fill")
        favouriteIcon.tintColor = .systemYellow
        favouriteIcon.backgroundColor = .white
        favouriteIcon.layer.cornerRadius = 12.5
        favouriteIcon.clipsToBounds = true
        favouriteIcon.contentMode = .center
        favouriteIcon.translatesAutoresizingMaskIntoConstraints = false
        favouriteIcon.isHidden = true
        movieView.addSubview(favouriteIcon)
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[movieView]|", options: [], metrics: nil, views: layoutDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[movieView]-5-|", options: [], metrics: nil, views: layoutDict))
        
        movieView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[posterImageView]-5-[movieTitle(40)]-5-[ratingsView(20)]-10-|", options: [], metrics: nil, views: layoutDict))
        
        movieView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[posterImageView]|", options: [], metrics: nil, views: layoutDict))
        
        movieView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[movieTitle]-8-|", options: [], metrics: nil, views: layoutDict))
        
        movieView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[ratingsView]", options: [], metrics: nil, views: layoutDict))
        
        movieView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[durationLabel]-10-|", options: [], metrics: nil, views: layoutDict))
        
        durationLabel.heightAnchor.constraint(equalTo: ratingsView.heightAnchor).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: ratingsView.centerYAnchor).isActive = true
        
        favouriteIcon.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5).isActive = true
        favouriteIcon.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -5).isActive = true
        favouriteIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        favouriteIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    
}
