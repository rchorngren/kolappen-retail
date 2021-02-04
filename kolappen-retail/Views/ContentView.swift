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
    
    @State var usernameInput : String = ""
    @State var passwordInput : String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                VStack {
                    Spacer()
                    Text("Kölappen")
                        .foregroundColor(Color("Text"))
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                    Spacer()
                    VStack {
                        TextField("Användarnamn", text: $usernameInput)
                            .padding(.bottom, 20)
                        SecureField("Lösenord", text: $passwordInput)
                    }
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                    Button(action: {
                            buttonPressed()
                    }) {
                        Text("Logga in")
                            .font(.title2)
                            .foregroundColor(Color("Text"))
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SupportView()) {
                            Text("Kontakta support")
                                .font(.system(size: 14))
                                .foregroundColor(Color("Link"))
                                .padding(.horizontal)
                        }
                    .padding(.bottom, 50)
                }
            }
            .ignoresSafeArea()
//            .onAppear() {
//                db.collection("test").addDocument(data: ["name" : "Robert"])
//            }
        }
        
        
    }
    private func buttonPressed() {
        print("username: \(usernameInput)")
        print("password: \(passwordInput)")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environment(\.colorScheme, .dark)
//    }
//}
