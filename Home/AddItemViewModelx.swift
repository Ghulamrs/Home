//
//  AddItemViewModel.swift
//  TodoList
//
//  Created by Home on 12/25/20.
//

import Foundation

class AddItemViewModel: ObservableObject {
    var date    = Date()
    var title:    String = ""
    var supplier: String = ""
    var quantity: String = ""
    var rate:     String = ""
    var units:  [String] = ["sets", "k", "bags", "dumper", "tonns", "sqft"]
    var titles: [String] = ["AsEntered", "Bricks", "Cement", "Crush", "Steel Rods", "Sand", "Pipes/Electric", "Parl-Pencil", "Parl-Crystal", "Ziarat-Gray", "Wooden-door", "Windows", "Grill"]
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        self.date = dateFormatter.date(from: "11/9/2020")!
    }
}
