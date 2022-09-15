//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by Atil Samancioglu on 15.09.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    
    private let nameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
      return label
    }()
    
    private let usernameLabel: UILabel = {
      let label = UILabel()
        label.textAlignment = .center
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
      label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    fetchUsers()
  }
  
  private func setupViews() {
    view.backgroundColor = .white
    
    view.addSubview(emailLabel)
      view.addSubview(nameLabel)
      view.addSubview(usernameLabel)
    
    NSLayoutConstraint.activate([
      nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 60),
      nameLabel.widthAnchor.constraint(equalToConstant: 200),
      nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      
      emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      emailLabel.heightAnchor.constraint(equalToConstant: 60),
      emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      
      usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      usernameLabel.heightAnchor.constraint(equalToConstant: 60),
      usernameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10)

      
    ])
  }
  
  private func fetchUsers() {
    APIManager.shared.fetchUser { result in
      switch result {
      case .success(let user):
          DispatchQueue.main.async {
              self.usernameLabel.text = user.username
              self.emailLabel.text = user.email
              self.nameLabel.text = user.name
          }
      case .failure:
          DispatchQueue.main.async {
              self.emailLabel.text = "No user found"
          }
      }
    }
  }
}





