//
//  ProfileViewController.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let photoImage = UIImageView(image: UIImage(named: "foto"), contentMode: .scaleAspectFit)
    private let nameLabel = UILabel(text: "Aleksei Baranov", textColor: .customOrange, font: .defaultBold24)
    private let genderLabel = UILabel(text: "Male", textColor: .darkBlue, font: .defaultBold18)
    private let bornLabel = UILabel(text: "Born 30.04.1989", textColor: .darkBlue, font: .defaultBold18)
    private let phoneLabel = UILabel(text: "+7 (925) 178-86-48", textColor: .darkBlue, font: .default18)
    private let emailLabel = UILabel(text: "alex.control@mail.ru", textColor: .darkBlue, font: .default18)
    private let separator = UILabel(text: "|", textColor: .darkBlue, font: .defaultBold14)
    private var stackView = UIStackView()
    private var buttonsStackView = UIStackView()
    private let cancelButton = UIButton(image: UIImage(systemName: "multiply"),
                                tintColor: .customOrange,
                                backgroundColor: .lightBeige)
    let callButton = UIButton()
    let mailButton = UIButton()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .beige
        setupPhoto()
        setupButtonsAction()
        setupStackView()
        setupContactsButtons()
        setupButtonsStackView()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeRound()
    }
    
    private func makeRound() {
        [cancelButton, photoImage, callButton, mailButton].forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
    
    private func setupPhoto() {
        photoImage.layer.masksToBounds = true
        photoImage.layer.borderColor = UIColor.lightBeige.cgColor
        photoImage.layer.borderWidth = 5
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [bornLabel, separator, genderLabel],
                                spacing: 5, semanticContentAttribute: .forceRightToLeft)
    }
    
    private func setupContactsButtons() {
        callButton.backgroundColor = .lightBeige
        callButton.setImage(named: "phone", style: .contacts)
        mailButton.backgroundColor = .lightBeige
        mailButton.setImage(named: "envelope", style: .contacts)
    }
    
    private func setupButtonsStackView() {
        buttonsStackView = UIStackView(arrangedSubviews: [callButton, mailButton],
                                       spacing: 20)
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
    }
    
    private func setupButtonsAction() {
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc func goBack() {
        dismiss(animated: true)
    }

    private func setupConstraints() {
        [cancelButton, photoImage, nameLabel,
         stackView, phoneLabel, emailLabel,
         buttonsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -StyleGuide.Spaces.single),
            cancelButton.widthAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            photoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            photoImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            photoImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: photoImage.topAnchor, constant: -StyleGuide.Spaces.double),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -StyleGuide.Spaces.single),
            
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: StyleGuide.Spaces.double),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: StyleGuide.Spaces.single),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: StyleGuide.Spaces.double),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 140),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
