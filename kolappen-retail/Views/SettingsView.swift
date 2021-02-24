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
    
    @Binding var loginSuccess : Bool
    
    @State var uid : String = ""
    @State var shopName : String = ""
    @State var currentQueueNumber : Int = 0
    @State var highestQueueNumber : Int = 0
    @State var queueLength : Int = 0
    @State var documentId : String = ""
    @State private var shopOpen : Bool = false
    
    @State private var openingHours = [String]()
    
    @State private var timePickerMondayOpen = Date()
    @State private var timePickerMondayClose = Date()
    @State private var timePickerTuesdayOpen = Date()
    @State private var timePickerTuesdayClose = Date()
    @State private var timePickerWednesdayOpen = Date()
    @State private var timePickerWednesdayClose = Date()
    @State private var timePickerThursdayOpen = Date()
    @State private var timePickerThursdayClose = Date()
    @State private var timePickerFridayOpen = Date()
    @State private var timePickerFridayClose = Date()
    @State private var timePickerSaturdayOpen = Date()
    @State private var timePickerSaturdayClose = Date()
    @State private var timePickerSundayOpen = Date()
    @State private var timePickerSundayClose = Date()
    
    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Text("Inställningar")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("Text"))
                
                Button("Logga ut") {
                    loginSuccess = false
                }
                .foregroundColor(Color("Link"))
                .padding(.top)
                
                Toggle("Öppet", isOn: $shopOpen)
                    .onChange(of: shopOpen) { value in
                        shopOpenToggle()
                    }
                    .foregroundColor(Color("Text"))
                    .font(.title3)
                    .padding(.top)
                    .padding(.leading, 80)
                    .padding(.trailing, 80)
                    .padding(.bottom)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Text("Öppettider")
                    .foregroundColor(Color("Text"))
                    .font(.title2)
                    .padding(.bottom)
                VStack {
                    HStack {
                        DatePicker("Måndag", selection: $timePickerMondayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Måndag", selection: $timePickerMondayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack {
                        DatePicker("Tisdag", selection: $timePickerTuesdayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Tisdag", selection: $timePickerTuesdayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack {
                        DatePicker("Onsdag", selection: $timePickerWednesdayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Onsdag", selection: $timePickerWednesdayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack {
                        DatePicker("Torsdag", selection: $timePickerThursdayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Torsdag", selection: $timePickerThursdayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack{
                        DatePicker("Fredag", selection: $timePickerFridayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Fredag", selection: $timePickerFridayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack {
                        DatePicker("Lördag", selection: $timePickerSaturdayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Lördag", selection: $timePickerSaturdayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    HStack {
                        DatePicker("Söndag", selection: $timePickerSundayOpen, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                        DatePicker("Söndag", selection: $timePickerSundayClose, displayedComponents: .hourAndMinute)
                            .foregroundColor(Color("Text"))
                            .labelsHidden()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Button(action: {
                            savedHours()
                        }) {
                            Text("Spara")
                                .font(.title2)
                                .foregroundColor(Color("Link"))
                                .padding(.top)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
            }
            
        }
        .ignoresSafeArea()
        .onAppear() {
            loadDataFromFirebase()
        }
    }
    
    private func logoutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Det blev ett fel i utloggningen: %@", signOutError)
        }
    }
    
    private func shopOpenToggle() {
        db.collection("users").document(documentId).updateData(["shopOpen" : shopOpen])
    }
    
    private func loadDataFromFirebase() {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            _ = user.email
            
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

                                let openingHours = shop.hoursOpen
                                let closingHours = shop.hoursClosed

                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
                                
                                timePickerMondayOpen = dateFormatter.date(from: openingHours[0])!
                                timePickerTuesdayOpen = dateFormatter.date(from: openingHours[1])!
                                timePickerWednesdayOpen = dateFormatter.date(from: openingHours[2])!
                                timePickerThursdayOpen = dateFormatter.date(from: openingHours[3])!
                                timePickerFridayOpen = dateFormatter.date(from: openingHours[4])!
                                timePickerSaturdayOpen = dateFormatter.date(from: openingHours[5])!
                                timePickerSundayOpen = dateFormatter.date(from: openingHours[6])!
                                
                                timePickerMondayClose = dateFormatter.date(from: closingHours[0])!
                                timePickerTuesdayClose = dateFormatter.date(from: closingHours[1])!
                                timePickerWednesdayClose = dateFormatter.date(from: closingHours[2])!
                                timePickerThursdayClose = dateFormatter.date(from: closingHours[3])!
                                timePickerFridayClose = dateFormatter.date(from: closingHours[4])!
                                timePickerSaturdayClose = dateFormatter.date(from: closingHours[5])!
                                timePickerSundayClose = dateFormatter.date(from: closingHours[6])!
                                
                                
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
        
        let openingHours = ["\(timePickerMondayOpen)", "\(timePickerTuesdayOpen)", "\(timePickerWednesdayOpen)", "\(timePickerThursdayOpen)", "\(timePickerFridayOpen)", "\(timePickerSaturdayOpen)", "\(timePickerSundayOpen)"]
        let closingHours = ["\(timePickerMondayClose)", "\(timePickerTuesdayClose)", "\(timePickerWednesdayClose)", "\(timePickerThursdayClose)", "\(timePickerFridayClose)", "\(timePickerSaturdayClose)", "\(timePickerSundayClose)"]
        
        db.collection("users").document(documentId).updateData(["hoursOpen" : openingHours])
        db.collection("users").document(documentId).updateData(["hoursClosed" : closingHours])
    }
    
    
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .environment(\.colorScheme, .dark)
//    }
//}
