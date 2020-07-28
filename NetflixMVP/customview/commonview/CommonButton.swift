//
//  CommonButton.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 28/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

@IBDesignable
class CommonButton: UIButton {
    
    @IBInspectable
    var isActive : Bool = true {
        didSet {
            handleButtonState()
        }
    }
    
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
    
    private func buildView() {
        
        backgroundColor = UIView().tintColor
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.lightGray.cgColor
        
        handleButtonState()
    }
    
    private func handleButtonState() {
        if isActive {
            activeState()
        }
        else {
            inactiveState()
        }
    }
    
    private func activeState() {
        isEnabled = true
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
    }
    
    private func inactiveState() {
        backgroundColor = UIColor.gray
        isEnabled = false
        setTitleColor(.black, for: .normal)
        
    }
}
