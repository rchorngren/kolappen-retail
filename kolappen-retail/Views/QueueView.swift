//
//  QueueScreen.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-08.
//
import SwiftUI
import Firebase

struct QueueView: View {
    
    var db = Firestore.firestore()
    
    @Binding var loginSuccess : Bool
    
    @State var uid : String = ""
    @State var shopName : String = ""
    @State var currentQueueNumber : Int = 0
    @State var highestQueueNumber : Int = 0
    @State var queueLength : Int = 0
    @State var documentId : String = ""
    
    @State private var buttonDisabled : Bool = false
    
    var body: some View {

            ZStack {
                Color("Background")
                VStack {
                    Spacer()
                    Text("Nu betjänas")
                        .foregroundColor(Color("Text"))
                    Text("\(currentQueueNumber)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("Text"))
                    Spacer()
                    Text("Personer i kö")
                        .foregroundColor(Color("Text"))
                    Text("\(queueLength)")
                        .foregroundColor(Color("Text"))
                        .padding(.bottom, 50)
                    Button(action: {
                        nextCustomer()
                    }, label: {
                        Text("Nästa kund")
                        .font(.title2)
                        .foregroundColor(Color("Text"))
                        .padding(.horizontal)
                    })
                    .padding(.bottom, 50)
                    .disabled(queueLength == 0)
                    
                    HStack {
                        NavigationLink(
                            destination: SupportView()) {
                                Text("Kontakta support")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("Link"))
                                    .padding(.horizontal)
                            }
                        NavigationLink(
                            destination: SettingsView(loginSuccess : $loginSuccess)) {
                                Text("Inställningar")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("Link"))
                                    .padding(.horizontal)
                            }
                    }
                    .padding(.bottom, 50)
                    
                }
            }
            .navigationBarTitle("\(shopName)")
//            .navigationBarItems(trailing: NavigationLink(
//                                        destination: SettingsView()) {
//                                            Text("Inställningar")
//                                        }
//                ).navigationBarBackButtonHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .onAppear() {
                verifyUser()
            }
        
        
    }
    
    private func nextCustomer() {
        if queueLength > 0 {
            let newQueueNumber = currentQueueNumber + 1
            do {
                db.collection("users").document(documentId).updateData(["currentQueueNumber" : newQueueNumber])
            }
        }
    }
    
    private func verifyUser() {
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
                                    currentQueueNumber = shop.currentQueueNumber
                                    highestQueueNumber = shop.highestQueueNumber
                                    queueLength = highestQueueNumber - currentQueueNumber
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
    
}


//struct QueueView_Previews: PreviewProvider {
//    static var previews: some View {
//        QueueView()
//            .environment(\.colorScheme, .dark)
//    }
//}
