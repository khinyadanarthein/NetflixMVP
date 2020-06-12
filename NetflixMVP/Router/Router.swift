//
//  Router.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 30/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
        
    var mainStoryBoard:UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var detailStoryBoard:UIStoryboard {
        return UIStoryboard(name: "Details", bundle: nil)
    }
    
    func navigateToDetail(movie : MovieDetailVO){
        
        let vc = mainStoryBoard.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
        if let vc = vc {
            vc.movie = movie
            print("movie id \(movie.id)")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    func navigateToProfile(){
        
        let vc = mainStoryBoard.instantiateViewController(identifier: ProfileViewController.identifier) as? ProfileViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            vc.navigationItem.hidesBackButton = true
            vc.navigationItem.title = "Profile"
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToLogin(){
        
        let vc = mainStoryBoard.instantiateViewController(identifier: LoginViewController.identifier) as? LoginViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            vc.navigationItem.hidesBackButton = true
            vc.navigationItem.title = "Login"
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 200, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
