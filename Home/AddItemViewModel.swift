//
//  AddItemViewModel.swift
//  Home
//
//  Created by Home on 1/7/21.
//

import Foundation
import CoreData

class AddItemViewModel: ObservableObject {
    var date = Date()
    @Published var title:    String = ""
    @Published var supplier: String = ""
    @Published var quantity: String = ""
    @Published var rate:     String = ""
    @Published var uIndex:   Int = 0
    @Published var tIndex:   Int = 0
    let titles: [String] = ["Select", "Bricks", "Cement", "Crush", "Sand", "Steel Rods", "Doors", "Windows", "Marble", "Grill", "Paint", "Pipes/Electric", "Others"]
    let units:  [String] = ["unit",   "k",     "bag",  "dumper", "dumper", "ton",       "unit",  "sqft",    "sqft",   "sqft",  "sqft", "rupee", "feet"]
    var updateItem: Item!

    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
//        self.date = dateFormatter.date(from: "11/9/2020")!
        self.date = Date()
    }
    
    func populate(item: Item) {
        updateItem  = item
        self.title  = item.title!
        self.tIndex = titles.firstIndex(of: item.title!) ?? 0
        self.uIndex = units.unique().firstIndex(of: item.unit!) ?? 0
        self.supplier = item.supplier!
        self.quantity = String(item.quantity)
        self.rate   = String(item.rate)
        self.date   = item.date!
    }
    
    func findunit(value title: String) -> String? {
        let it = AddItemViewModel()
        if(it.titles.contains(title)) {
            for (index, value) in it.titles.enumerated() {
                if value == title {
                    return it.units[index]
                }
            }
        }
        return nil
    }
    
    func reset() {
        title  = ""
        supplier = ""
        quantity = ""
        rate = ""
        
        uIndex = 0
        tIndex = 0
    }
}
