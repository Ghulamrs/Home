//
//  AddItemView.swift
//  Home
//
//  Created by Home on 1/7/21.
//

import SwiftUI
import CoreData

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var ivm: AddItemViewModel

    var body: some View {
        VStack {
            Picker(selection: $ivm.tIndex, label: Text("\(ivm.titles[ivm.tIndex])")) {
                ForEach(0 ..< ivm.titles.count) {
                    Text(self.ivm.titles[$0])
                }
            }
            .onChange(of: ivm.tIndex, perform: { value in ivm.title = ivm.titles[ivm.tIndex] })
            .pickerStyle(MenuPickerStyle())
            TextField("title",    text: $ivm.title).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            TextField("supplier", text: $ivm.supplier)
            TextField("quantity", text: $ivm.quantity).foregroundColor(.red)
            TextField("rate",     text: $ivm.rate)
            Picker(selection: $ivm.uIndex, label: Text("Units")) {
                let units = ivm.units.unique()
                ForEach(0 ..< units.count) {
                    Text(units[$0])
                }
            }
            .pickerStyle(WheelPickerStyle())
            DatePicker("", selection: $ivm.date, displayedComponents: .date).labelsHidden()
        }
        .padding()
        
        HStack {
            Button(ivm.title.isEmpty ? "Add Now" : "Update") {
                if(ivm.title.isEmpty) { addItem() }
                else {
                    updateItem()
                }
                self.presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.green)
            .padding()
            Button("Cancel") {
                ivm.reset()
                if(ivm.updateItem != nil) { cancelItem() }
                self.presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.red)
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

    private func addItem() {
        withAnimation {
            let units = ivm.units.unique()
            let AsEntered = ivm.titles[ivm.tIndex]=="Select" ? true : false
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.title = AsEntered ? ivm.title : ivm.titles[ivm.tIndex]
            newItem.supplier = ivm.supplier
            newItem.date = ivm.date
            newItem.rate = Float(ivm.rate) ?? 0
            newItem.quantity = Float(ivm.quantity) ?? 1.0
            newItem.unit = AsEntered ? "" : units[ivm.uIndex]

            ivm.reset()
            saveContext()
        }
    }

    private func updateItem() {
        withAnimation {
            let units = ivm.units.unique()
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.title = ivm.tIndex==0 ? ivm.title : ivm.titles[ivm.tIndex]
            newItem.supplier = ivm.supplier
            newItem.date = ivm.date
            newItem.rate = Float(ivm.rate) ?? 0
            newItem.quantity = Float(ivm.quantity) ?? 1.0
            newItem.unit = units[ivm.uIndex]

            ivm.reset()
            saveContext()
        }
    }
    
    private func cancelItem() {
        withAnimation {
            let item = Item(context: viewContext)
            item.id = ivm.updateItem.id
            item.title = ivm.updateItem.title
            item.supplier = ivm.updateItem.supplier
            item.date = ivm.updateItem.date
            item.rate = ivm.updateItem.rate
            item.quantity = ivm.updateItem.quantity
            item.unit = ivm.updateItem.unit

            ivm.reset()
            saveContext()
        }
    }
}
