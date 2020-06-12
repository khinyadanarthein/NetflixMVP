//
//  BasePresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
class BasePresenter<M> : BaseMVP   {
    typealias V = M
    
    var mView: M?
    let model:DataModel  = DataModelImpl.shared
    
    func onAttach(view: M) {
        self.mView = view
    }
    
    func onDetach() {
         self.mView = nil
    }
    
    func onUIReady() {
        
    }
    
}
