//
//  ProfileView.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//

import UIKit


class ProfileView: UIView {
    
    
    var backButton = UIButton()
    
    var greetingLabel = UILabel()
    var editNameButton = UIButton()
    
    var layoutDict = [String: Any]()
    
    func setupViews(_ baseView: UIView) {
        baseView.backgroundColor = .themeColor
        
        backButton.contentMode = .scaleAspectFill
        backButton.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.tintColor = .secondaryColor
        layoutDict["backButton"] = backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(backButton)
        
        greetingLabel.font = UIFont.boldSystemFont(ofSize: 28)
        greetingLabel.textColor = .label
        greetingLabel.textAlignment = .center
        greetingLabel.numberOfLines = 2
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["greetingLabel"] = greetingLabel
        baseView.addSubview(greetingLabel)
        
        editNameButton.setTitle("Edit Name", for: .normal)
        editNameButton.setTitleColor(.themeTxtColor, for: .normal)
        editNameButton.backgroundColor = .themeColor
        editNameButton.layer.borderWidth = 1
        editNameButton.layer.borderColor = UIColor.secondThemeColor.cgColor
        editNameButton.layer.cornerRadius = 8
        editNameButton.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["editNameButton"] = editNameButton
        baseView.addSubview(editNameButton)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            
            greetingLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -20),
            greetingLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20),
            
            editNameButton.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 30),
            editNameButton.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            editNameButton.widthAnchor.constraint(equalToConstant: 140),
            editNameButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

