//
//  FilterView.swift
//  Pantry
//
//  Created by Yaniv Amiri on 11/17/20.
//

import SwiftUI

struct FilterView: View {
    let inputFilters : [String] = ["African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mediterranean", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"]
    @Binding var activeFilters : [String]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100))], spacing: 20, content: {
                ForEach(0..<inputFilters.count) {ind in
                Button(inputFilters[ind]) {
                    if(!activeFilters.contains(inputFilters[ind])) { activeFilters.append(inputFilters[ind]) }
                    else {activeFilters.remove(at: activeFilters.firstIndex(of: inputFilters[ind])!)}
                }.frame(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight: 100).border(Color.blue, width: 1).background(!activeFilters.contains(inputFilters[ind]) ? Color.white : Color.blue).foregroundColor(!activeFilters.contains(inputFilters[ind]) ? .blue : .white).cornerRadius(3)
                }
            }).padding(.top, 20)
        }
    }
}
