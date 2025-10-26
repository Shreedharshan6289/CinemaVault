//
//  MovieDetailsPage.swift
//  CinemaVault
//
//  Created by Apple on 25/10/25.
//

import UIKit
import AVFoundation
import AVKit

class MovieDetailsView: UIView {
    
    var backButton = UIButton()
    var movieTitleLabel = UILabel()
    var favouriteButton = UIButton()
    
    var trailerThumbnail = UIImageView()
    
    var trailerContainer = UIView()
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playButton = UIButton()
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    var ratingsView = UIView()
    var ratingsLabel = UILabel()
    
    var durationLabel = UILabel()
    
    var genreLabel = UILabel()
    
    var plotLabel = UILabel()
    
    var castScrollView = UIScrollView()
    var castStackView = UIStackView()
    
    var loader = UIActivityIndicatorView(style: .large)
    
    var layoutDict = [String:Any]()
    
    func setupViews(_ baseView: UIView) {
        
        baseView.backgroundColor = .themeColor
        
        backButton.contentMode = .scaleAspectFill
        backButton.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.tintColor = .secondaryColor
        layoutDict["backButton"] = backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(backButton)
        
        movieTitleLabel.textColor = .themeTxtColor
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        movieTitleLabel.textAlignment = .left
        layoutDict["movieTitleLabel"] = movieTitleLabel
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(movieTitleLabel)
        
        favouriteButton.contentMode = .scaleAspectFit
        favouriteButton.setImage(UIImage(named: "ic_fav_unselected"), for: .normal)
        favouriteButton.setImage(UIImage(named: "ic_fav_selected"), for: .selected)
        layoutDict["favouriteButton"] = favouriteButton
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(favouriteButton)
        
        trailerContainer.backgroundColor = .black
        trailerContainer.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["trailerContainer"] = trailerContainer
        baseView.addSubview(trailerContainer)
        
        trailerThumbnail.contentMode = .scaleAspectFill
        trailerThumbnail.clipsToBounds = true
        layoutDict["trailerThumbnail"] = trailerContainer
        trailerThumbnail.translatesAutoresizingMaskIntoConstraints = false
        trailerContainer.addSubview(trailerThumbnail)
        
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playButton.tintColor = .white
        playButton.translatesAutoresizingMaskIntoConstraints = false
        trailerContainer.addSubview(playButton)
        
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["scrollView"] = scrollView
        baseView.addSubview(scrollView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["containerView"] = containerView
        scrollView.addSubview(containerView)
        
        
        layoutDict["ratingsView"] = ratingsView
        ratingsView.backgroundColor = .blackColor.withAlphaComponent(0.3)
        ratingsView.layer.cornerRadius = 10
        ratingsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(ratingsView)
        
        ratingsLabel.textColor = .themeTxtColor
        ratingsLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        ratingsLabel.textAlignment = .left
        layoutDict["ratingsLabel"] = ratingsLabel
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsView.addSubview(ratingsLabel)
        
        durationLabel.textColor = .themeTxtColor
        durationLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        durationLabel.textAlignment = .right
        layoutDict["durationLabel"] = durationLabel
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsView.addSubview(durationLabel)
        
        genreLabel.textColor = .themeTxtColor
        genreLabel.backgroundColor = .blackColor.withAlphaComponent(0.3)
        genreLabel.layer.cornerRadius = 10
        genreLabel.clipsToBounds = true
        genreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        genreLabel.textAlignment = .left
        layoutDict["genreLabel"] = genreLabel
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(genreLabel)
        genreLabel.textColor = .themeTxtColor
        genreLabel.backgroundColor = .blackColor.withAlphaComponent(0.3)
        genreLabel.layer.cornerRadius = 10
        genreLabel.clipsToBounds = true
        genreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        genreLabel.textAlignment = .left
        layoutDict["genreLabel"] = genreLabel
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(genreLabel)
        
        plotLabel.textColor = .themeTxtColor
        plotLabel.numberOfLines = 0
        plotLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        plotLabel.textAlignment = .justified
        layoutDict["plotLabel"] = plotLabel
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(plotLabel)
        
        castScrollView.showsHorizontalScrollIndicator = false
        castScrollView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["castScrollView"] = castScrollView
        containerView.addSubview(castScrollView)
        
        castStackView.axis = .horizontal
        castStackView.spacing = 10
        castStackView.translatesAutoresizingMaskIntoConstraints = false
        castScrollView.addSubview(castStackView)
        
        loader.color = .white
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[backButton(35)]-10-[movieTitleLabel]-10-[favouriteButton(35)]-12-|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: layoutDict))
        
        trailerContainer.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15).isActive = true
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[trailerContainer]-12-|", options: [], metrics: nil, views: layoutDict))
        trailerContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        playButton.centerXAnchor.constraint(equalTo: trailerContainer.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: trailerContainer.centerYAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        trailerThumbnail.topAnchor.constraint(equalTo: trailerContainer.topAnchor).isActive = true
        trailerThumbnail.bottomAnchor.constraint(equalTo: trailerContainer.bottomAnchor).isActive = true
        trailerThumbnail.leadingAnchor.constraint(equalTo: trailerContainer.leadingAnchor).isActive = true
        trailerThumbnail.trailingAnchor.constraint(equalTo: trailerContainer.trailingAnchor).isActive = true
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[backButton(35)]-10-[trailerContainer]-15-[scrollView]-15-|", options: [], metrics: nil, views: layoutDict))
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: layoutDict))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[containerView]|", options: [], metrics: nil, views: layoutDict))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: [], metrics: nil, views: layoutDict))
        
        containerView.widthAnchor.constraint(equalTo: baseView.widthAnchor).isActive = true
        let containerHgt = containerView.heightAnchor.constraint(equalTo: baseView.heightAnchor)
        containerHgt.priority = .defaultLow
        containerHgt.isActive = true
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[ratingsView(40)]-12-[genreLabel(40)]-15-[plotLabel]-20-[castScrollView]-15-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDict))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[ratingsView]-12-|", options: [], metrics: nil, views: layoutDict))
        
        ratingsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[ratingsLabel]", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: layoutDict))
        
        ratingsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[durationLabel]-10-|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: layoutDict))
        
        
        ratingsLabel.heightAnchor.constraint(equalTo: ratingsView.heightAnchor).isActive = true
        ratingsLabel.centerYAnchor.constraint(equalTo: ratingsView.centerYAnchor).isActive = true
        
        durationLabel.heightAnchor.constraint(equalTo: ratingsView.heightAnchor).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: ratingsView.centerYAnchor).isActive = true
        
        castScrollView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        castScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        castScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        castStackView.topAnchor.constraint(equalTo: castScrollView.topAnchor).isActive = true
        castStackView.bottomAnchor.constraint(equalTo: castScrollView.bottomAnchor).isActive = true
        castStackView.leadingAnchor.constraint(equalTo: castScrollView.leadingAnchor).isActive = true
        castStackView.trailingAnchor.constraint(equalTo: castScrollView.trailingAnchor).isActive = true
        
    }
    
    
    func updateCastUI(_ cast: [CastMember]) {
        castStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for member in cast {
            let v = UIView()
            v.widthAnchor.constraint(equalToConstant: 80).isActive = true
            
            let imgView = UIImageView()
            imgView.layer.cornerRadius = 35
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(imgView)
            imgView.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
            imgView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imgView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imgView.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            
            if let urlStr = member.profilePath, let url = URL(string: urlStr) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                        DispatchQueue.main.async { imgView.image = img }
                    }
                }
            } else {
                imgView.image = UIImage(named: "placeholder")
            }
            
            let nameLbl = UILabel()
            nameLbl.text = member.name
            nameLbl.font = UIFont.systemFont(ofSize: 12)
            nameLbl.textColor = .white
            nameLbl.textAlignment = .center
            nameLbl.numberOfLines = 2
            nameLbl.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(nameLbl)
            nameLbl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 2).isActive = true
            nameLbl.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
            nameLbl.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true
            
            castStackView.addArrangedSubview(v)
        }
    }
    
}
