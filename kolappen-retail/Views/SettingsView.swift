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
    
    @State private var toggleSwitch = false
    @State private var openingMonday : String = ""
    @State private var closingMonday : String = ""

    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Text("Inställningar")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("Text"))
                    .padding()
                Toggle("Öppet", isOn: $toggleSwitch)
                    .foregroundColor(Color("Text"))
                    .font(.title3)
                    .padding(120)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                if toggleSwitch {
                    Text("Logged in!")
                }
                
                Text("Öppettider")
                    .foregroundColor(Color("Text"))
                    .font(.title2)
                    .padding(.bottom, 20)
                    .foregroundColor(Color("Text"))
                    .padding(.bottom)
                HStack {
                    TextField("Enter time", text: $openingMonday)
            
                }
                Button(action: {
                    savedHours()
                }) {
                    Text("Spara")
                        .font(.title2)
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                }
            }
                
        }
        .ignoresSafeArea()
        .onAppear() {
            print("settingsView")
        }
    }
    
    private func savedHours() {
        print("Monday ", openingMonday)
    }
    
    
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .environment(\.colorScheme, .dark)
//    }
//}
