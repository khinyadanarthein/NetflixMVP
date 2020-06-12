//
//  LoginViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 04/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    static var identifier : String {
        return "LoginViewController"
    }

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var viewShowpwd: UIView!
    @IBOutlet weak var labelShowHide: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    
    var mPresenter : LoginPresenter = LoginPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let disposebag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndicator()
        initDataObservationMVP()
        
        tfUserName.attributedPlaceholder = NSAttributedString(string: "User Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = UIColor.white.cgColor
        btnSignIn.layer.masksToBounds = true
        btnSignIn.layer.cornerRadius = 5
        
         viewShowpwd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showHideTapped(tapGestureRecognizer:))))
        
        labelShowHide.text = PWD_SHOW
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mPresenter.onUIReady()
    }
    
    @objc func showHideTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if labelShowHide.text == PWD_SHOW {
            tfPassword.isSecureTextEntry = false
            labelShowHide.text = PWD_HIDE
            
        } else {
            
            tfPassword.isSecureTextEntry = true
            labelShowHide.text = PWD_SHOW
        }
        
    }
    
    @IBAction func onTappedSignIn(_ sender: Any) {
        
        let userName = self.tfUserName.text
        let password = self.tfPassword.text
        
        if (!(userName?.isEmpty ?? false)) && (!(password?.isEmpty ?? false) ){
            self.signIn()
        } else {
            self.showLoginError()
        }
        
//        Observable.combineLatest(userName, password){ userName, password -> Bool in
//            return (!(userName?.isEmpty ?? false)) && (!(password?.isEmpty ?? false) )
//        }
//        .subscribe(onNext:{ isValid in
//            isValid ? self.signIn() : self.showLoginError()
//        })
//        .disposed(by: disposebag)
    }
    
    func signIn() {
        mPresenter.login(userName: self.tfUserName.text!, password: self.tfPassword.text!)
    }
    
    func showLoginError() {
        let err = "Please enter your info."
        let alert = UIAlertController(title: "Sign In", message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController : LoginView {
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(err: String) {
        debugPrint(err)
        let alert = UIAlertController(title: "Login Error", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToProfileDetail() {
        self.navigateToProfile()
    }
    
}
