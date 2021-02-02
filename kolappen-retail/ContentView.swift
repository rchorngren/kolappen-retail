//
//  ContentView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-01-26.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    
    var db = Firestore.firestore()
    
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
        .onAppear() {
            db.collection("test").addDocument(data: ["name" : "Robert"])
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environment(\.colorScheme, .dark)
//    }
//}
