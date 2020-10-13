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
    @Binding var activeIngredients : [String : String]
    var activeIngredient : String
    var body: some View {
        let binding = Binding<String>(get: {
                    self.amount
                }, set: {
                    self.amount = $0
                    self.activeIngredients[activeIngredient] = $0
                })
            TextField("Amount", text: binding).padding(.leading, 20.0).padding(.trailing, 20.0).navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
                activeIngredients[activeIngredient] = amount
            }){
                Image(systemName: "plus")
            }).labelsHidden()
    }
}
