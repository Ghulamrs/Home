//
//  HomeModel.swift
//  Home
//
//  Created by Home on 1/7/21.
//

import Foundation

class HomeModel: ObservableObject {
    var serial:Int = 1
    
    func advance() {
        serial += 1
    }
}
