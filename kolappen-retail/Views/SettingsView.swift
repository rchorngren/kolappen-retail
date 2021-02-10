//
//  SettingsView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-10.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SettingsView: View {

    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Text("SettingsView")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("Text"))
                    .padding(.top, 100)
            }
                
        }
        .ignoresSafeArea()
        .onAppear() {
            print("settingsView")
        }
        .navigationBarItems(leading: NavigationLink(
            destination: QueueView()) {
                Text("Tillbaka")
            })
        .navigationBarBackButtonHidden(true)
    }
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SupportView()
//            .environment(\.colorScheme, .dark)
//    }
//}
