//
//  CustomDetailViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 28/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class CustomDetailViewController: UIViewController {

    let mainScrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let ivBackPhoto : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "tour1")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let ivClearBtn : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "xmark.circle.fill")
        view.contentMode = .scaleAspectFill
        view.tintColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let ivPosterImage : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    let infoStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let lbReleaseDate : UILabel = {
        let label = UILabel()
        label.text = "2019-01-01"
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mainScrollView)
        self.mainScrollView.addSubview(ivBackPhoto)
        self.mainScrollView.addSubview(ivClearBtn)
        self.mainScrollView.addSubview(ivPosterImage)
        
        NSLayoutConstraint.activate([
            mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            ivBackPhoto.centerXAnchor.constraint(equalTo: self.mainScrollView.centerXAnchor, constant: 0),
            ivBackPhoto.heightAnchor.constraint(equalToConstant: 380),
            ivBackPhoto.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor, constant: 0),
            ivBackPhoto.trailingAnchor.constraint(equalTo: self.mainScrollView.trailingAnchor, constant: 0),
            ivBackPhoto.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor, constant: 0),
            
            ivClearBtn.widthAnchor.constraint(equalToConstant: 30),
            ivClearBtn.heightAnchor.constraint(equalToConstant: 30),
            ivClearBtn.trailingAnchor.constraint(equalTo: self.mainScrollView.trailingAnchor, constant: 20),
            ivClearBtn.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor, constant: 30),
            
            ivPosterImage.centerXAnchor.constraint(equalTo: self.mainScrollView.centerXAnchor, constant: 0),
            ivPosterImage.heightAnchor.constraint(equalToConstant: 220),
            ivPosterImage.widthAnchor.constraint(equalToConstant: 170),
            ivPosterImage.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor, constant: 90),
            
        ])
    }
    
}
