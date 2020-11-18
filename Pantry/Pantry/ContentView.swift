//
//  ContentView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 10/9/20.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView: View {
    @State private var showDetail = false
    @State private var searchText = ""
    @State private var activeIngredients : [String: String] = [:]
    @State private var activeFilters : [String] = []
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor =  UIColor(Color.init(hex: "#123524"))
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        let ingredientView = IngredientsView(searchText: searchText, activeFilters: $activeFilters, activeIngredients: $activeIngredients)
        let filterView = FilterView(activeFilters: $activeFilters).navigationBarTitleDisplayMode(.inline).toolbar(content: {
            ToolbarItem(placement: .principal) {
                HStack{
                    Text("")
                    Image("Artboard 1").resizable().frame(maxWidth: 100, maxHeight: 60).padding([.trailing], 30)
                }
            }
        })
        let recipesView = RecipesView(inputFilters: $activeFilters, inputIngredients: $activeIngredients).navigationBarItems(trailing: NavigationLink("Filters View", destination: filterView)).navigationBarTitleDisplayMode(.inline).toolbar(content: {
            ToolbarItem(placement: .principal) {
                HStack{
                    Text("")
                    Image("Artboard 1").resizable().frame(maxWidth: 100, maxHeight: 60).padding([.trailing], 30)
                }
            }
        })
    
            
        
        return NavigationView {
            VStack{
            ingredientView.sheet(isPresented: $showDetail) {
                Text("Active Ingredients:").font(.title)
                ForEach(activeIngredients.keys.sorted(by: >), id: \.self) { key in
                    Text("Ingredient: \(key.capitalizingFirstLetter()), amount:  \(activeIngredients[key]!)")
                }
            }.background(Color(hex: "#f9f9f9")).navigationBarTitleDisplayMode(.inline).toolbar(content: {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Text("")
                        Image("Artboard 1").resizable().frame(maxWidth: 100, maxHeight: 60).padding([.trailing], 30)
                    }
                }
            }).navigationBarItems(
                leading: HStack {
                    
                    TextField("Search", text: $searchText)
                        .padding(7)
                        .padding(.leading, 30).padding(.trailing, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10).foregroundColor(.black)
                }.frame(minWidth: 150, minHeight: 75).overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading, 25)
                        }
                ),
                trailing: NavigationLink("Find Recipes!", destination: recipesView).foregroundColor(.blue)
            )
                Button("Active ingredients") {
                    self.showDetail = true
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
