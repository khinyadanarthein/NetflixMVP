//
//  MVPprotocol.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol BaseMVP {
    associatedtype V
    var mView: V? { get set }
    var isAttached: Bool { get }
    
    func onAttach(view: V)
    func onDetach()
    func onUIReady()
}

extension BaseMVP {
    var isAttached: Bool { return mView != nil }
    
}
