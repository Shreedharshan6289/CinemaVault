//
//  ProfileVC.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//


import UIKit

class ProfileVC: UIViewController {
    
    var profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.setupViews(self.view)
        setupButtons()
        loadUserName()
        
    }
    
    func setupButtons() {
        profileView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        profileView.editNameButton.addTarget(self, action: #selector(editNameTapped), for: .touchUpInside)
    }
    
    func loadUserName() {
        let name = UserDefaults.standard.string(forKey: "user_name") ?? "Guest"
        profileView.greetingLabel.text = "Hello, \(name)!"
    }
    
    @objc func editNameTapped() {
        let alert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = UserDefaults.standard.string(forKey: "user_name") ?? "Guest"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            let newName = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Guest"
            UserDefaults.standard.set(newName, forKey: "user_name")
            self.profileView.greetingLabel.text = "Hello, \(newName)!"
        }))
        present(alert, animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
