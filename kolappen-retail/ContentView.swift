//
//  ContentView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-01-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Text("Hello, Nynäs")
                    .foregroundColor(Color("Text"))
                Text("Hello, Mainland")
                    .foregroundColor(Color("Text"))
            }
            
        }
        .ignoresSafeArea()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
