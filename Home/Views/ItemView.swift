//
//  TxnView.swift
//  Home
//
//  Created by Home on 1/8/21.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        Text("\(item.date!, formatter: itemFormatter)").font(.caption)
        Text("\(item.title!) ... \(item.quantity, specifier: (item.quantity==floor(item.quantity) ? "%1.0f" : "%g")) \(item.unit!)")
        Text("@\(item.rate, specifier: "%1.0f") by \(item.supplier!)")
            .font(.system(size: 14.0)).fontWeight(.regular)
            .frame(width: UIScreen.main.bounds.width-40, height: 15, alignment: .trailing)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
