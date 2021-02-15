//
//  SettingsView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-10.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct SettingsView: View {
    
    @State private var shopOpen : Bool = false
    @State private var openingMonday : String = ""
    @State private var closingMonday : String = ""
    
    @State var uid : String = ""
    @State var shopName : String = ""
    @State var currentQueueNumber : Int = 0
    @State var highestQueueNumber : Int = 0
    @State var queueLength : Int = 0
    @State var documentId : String = ""
    
    @State private var timePicker = Date()
    //@State var timeZone : TimeZone? { get set }
    
    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Spacer()
                Text("Inställningar")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("Text"))
                    .padding()
                Toggle("Öppet", isOn: $shopOpen)
                    .onChange(of: shopOpen) { value in
                        shopOpenToggle()
                    }
                    .foregroundColor(Color("Text"))
                    .font(.title3)
                    .padding(50)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Text("Öppettider")
                    .foregroundColor(Color("Text"))
                    .font(.title2)
                    .padding(.bottom, 10)
                //HStack {
                    Form {
                        Section(header: Text("Välj tid")) {
                            DatePicker("Måndag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Tisdag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Onsdag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Torsdag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Fredag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Lördag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                            DatePicker("Söndag", selection: $timePicker, displayedComponents: .hourAndMinute)
                                .foregroundColor(Color("Text"))
                        }
                    }
                //}
                .padding()
                
                Button(action: {
                savedHours()
                }) {
                    Text("Spara")
                        .font(.title2)
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                }
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .onAppear() {
            loadDataFromFirebase()
        }
    }
    
    private func shopOpenToggle() {
        db.collection("users").document(documentId).updateData(["shopOpen" : shopOpen])
    }
    
    private func loadDataFromFirebase() {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            let email = user.email
            print("loggedin user: \(uid) \(email!)")
            
            db.collection("users").whereField("uid", isEqualTo: uid).addSnapshotListener() { (snapshot, error) in
                if let error = error {
                    print("there was an error regarding snapshot: \(error)")
                } else {
                    for document in snapshot!.documents {
                        
                        let result = Result {
                            try document.data(as: Shop.self)
                        }
                        
                        switch result {
                        case .success(let shop):
                            if let shop = shop {
                                shopName = shop.shopName
                                shopOpen = shop.shopOpen
                                documentId = document.documentID
                                
                            } else {
                                print("Document does not exist")
                            }
                        case.failure(let error):
                            print("Error decoding item: \(error)")
                        }
                        
                    }
                }
            }
        }
    }
    
    private func savedHours() {
        print("Monday \(shopName)")
    }
    
    
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .environment(\.colorScheme, .dark)
//    }
//}
