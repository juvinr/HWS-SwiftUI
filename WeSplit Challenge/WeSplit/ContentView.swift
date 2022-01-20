//
//  ContentView.swift
//  WeSplit
//
//  Created by Juvin R on 20/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocussed: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20]
    
    // Compute total amount per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = totalAmount * tipSelection / 100
        let grandTotal = totalAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Compute total amount including tip value
    var totalPlusTip: Double {
        let grandTotal = totalPerPerson * Double(numberOfPeople + 2)
        return grandTotal
    }
    
    // Currency Code
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                // Total Bill Amount and Number of people
                Section {
                    TextField("Amount", value: $totalAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocussed)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // Tip Percentage
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // Total Bill Amount plus tip value
                Section {
                    Text(totalPlusTip, format: currencyCode)
                } header: {
                    Text("Total Amount including tip value")
                }
                
                // Total Bill Amount Per Person
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocussed = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}
