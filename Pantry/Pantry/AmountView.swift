//
//  AmountView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/13/20.
//

import SwiftUI

struct AmountView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var amount : String = ""
    @State private var selectedUnit = 0
    @Binding var activeIngredients : [String : String]
    var activeIngredient : CollectionViewImage
    
    var body: some View {
        ZStack{
            Color.gray
                .edgesIgnoringSafeArea(.all)
            let binding = Binding<String>(get: {
                        self.amount
                    }, set: {
                        self.amount = $0
                    })
            VStack(spacing: 50){
                let name = activeIngredient.name
                Text("Ingredient: \(name)")
                    .font(.system(size: 45, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("Please enter amount and unit below:")
                    .font(.system(size: 40, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(20.0)
                HStack{
                    TextField("Amount", text: binding)
                        .font(Font.system(size: 18, weight: .medium, design: .serif))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                        .background(Color.white)
                        .fixedSize()
                        .padding(.leading, 20.0)
                        .padding(.trailing, 20.0)
                        .navigationBarItems(leading: Button("Add to List", action : {
                        self.mode.wrappedValue.dismiss()
                            activeIngredients[activeIngredient.name] = amount + " "
                                + activeIngredient.possibleUnits[selectedUnit]
                    }), trailing: Button("Remove from List", action: {
                        self.mode.wrappedValue.dismiss()
                        activeIngredients.removeValue(forKey: activeIngredient.name)
                    })).labelsHidden()
                    Picker(selection: $selectedUnit, label: Text("Please Pick Measuring Units")) {
                        ForEach(0 ..< activeIngredient.possibleUnits.count) {
                            Text(self.activeIngredient.possibleUnits[$0])
                                .font(Font.system(size: 20))
                        }
                    }
                    .frame(width: 150)
                    .clipped()
                }
            }
        }
    }
}
