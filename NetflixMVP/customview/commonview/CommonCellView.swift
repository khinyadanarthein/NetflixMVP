//
//  CommonCellView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 27/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

@IBDesignable
class CommonCellView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        buildView()
    }
     
     override func prepareForInterfaceBuilder() {
         super.prepareForInterfaceBuilder()
         self.buildView()
         
     }
    
    @IBInspectable
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backImageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    let logoImageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "netfilx-64")
        view.backgroundColor = .none
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    func buildView() {
        //self.addSubview(mainView)
        self.addSubview(backImageView)
        self.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
//            backImageView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0),
//            backImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 0),
//            backImageView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 0),
//            backImageView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: 0),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 25),
            logoImageView.heightAnchor.constraint(equalToConstant: 35),
            logoImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 5),
            logoImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 5)
        ])
    }
}
