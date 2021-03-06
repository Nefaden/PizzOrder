//
//  OrderSheet.swift
//  PizzOrder
//
//  Created by Yann Durand on 24/09/2020.
//

import Foundation
import SwiftUI

struct OrderSheet: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode

       
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pizza Details")) {
                    Picker(selection: $selectedPizzaIndex, label: Text("Pizza Type")) {
                        ForEach(0 ..< pizzaTypes.count) {
                                Text(self.pizzaTypes[$0]).tag($0)
                        }
                    }
                    
                    Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
                }
                
                Section(header: Text("Table")) {
                    TextField("Table Number", text: $tableNumber)
                        .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                guard self.tableNumber != "" else {return}
                let newOrder = Order(context: self.managedObjectContext)
                                    newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                                    newOrder.orderStatus = .pending
                                    newOrder.tableNumber = self.tableNumber
                                    newOrder.numberOfSlices = Int16(self.numberOfSlices)
                                    newOrder.uuid = UUID()
                                    do {
                                      try self.managedObjectContext.save()
                                      print("Order saved.")
                                        self.presentationMode.wrappedValue.dismiss()
                                     } catch {
                                      print(error.localizedDescription)
                                      }
                                }) {
                Text("Add Order")
                }
                
            }
        }
    }
}
