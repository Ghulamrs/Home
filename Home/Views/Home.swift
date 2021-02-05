//
//  Home.swift
//  Home
//
//  Created by Home on 1/7/21.
//

import SwiftUI
import CoreData

struct Home: View {
    @Binding var items: [Item]
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var ivm = AddItemViewModel()

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: -20) {
                    ForEach(items) { item in
                        VStack(alignment: .leading, spacing: 5, content: {
                            ItemView(item: item)
                            Divider()
                        })
                        .padding()
                        .contextMenu {
                            Button(action: {
                                 viewContext.delete(item)
                                 saveContext()
                            }, label: {
                                 Text("Delete")
                            })
                            Button(action: {
                                ivm.populate(item: item)
                                viewContext.delete(item)
                                isPresented.toggle()
                            }, label: {
                                 Text("Update")
                            })
                        }
                    }
                }
            })
            .sheet(isPresented: $isPresented, onDismiss: {
            }) {
                AddItemView(ivm: ivm)
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing: Button(action: {
                ivm.title = ""
                isPresented.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                .foregroundColor(.purple)
                .font(.title)
            }))
            
            if(!items.isEmpty) {
                Text("Rs. \(SumOf(items: self.items), specifier: "%5.0f")").font(.caption).foregroundColor(.red).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("\(CountOf(items: self.items)) \(UnitOf(value: self.items[0].title!)), \(items.count) txns").font(.caption).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            } else {
                Text("No items found!!").font(.caption).foregroundColor(.red).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Text("@2020: Home 7.0, G. R. Akhtar, Islamabad").font(.caption).foregroundColor(.gray)
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }

    func CountOf(items: [Item]) -> Int32 {
        var total: Int32 = 0
        for item in items {
            total += Int32(item.quantity)
        }
        return total
    }

    func SumOf(items: [Item]) -> Float {
        var total: Float = 0
        for item in items {
            total += item.rate*Float(item.quantity)
        }
        return total
    }

    func UnitOf(value title: String) -> String {
        let it = AddItemViewModel()
        return it.findunit(value: title) ?? "units"
    }
}
