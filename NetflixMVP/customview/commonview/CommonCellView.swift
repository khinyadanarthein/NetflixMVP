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
    let backImageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        view.backgroundColor = .black
        view.contentMode = .center
        return view
    }()
    let logoImageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "netfilx-64")
        view.backgroundColor = .none
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    func buildView() {
        self.addSubview(backImageView)
        self.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImageView.widthAnchor.constraint(equalTo: heightAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 25),
            logoImageView.heightAnchor.constraint(equalToConstant: 35),
            logoImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 5),
            logoImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 5)
        ])
    }
}
