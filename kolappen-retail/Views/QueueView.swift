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
    
    @State var uid : String = ""
    @State var shopName : String = ""
    @State var currentQueueNumber : Int = 0
    @State var highestQueueNumber : Int = 0
    @State var queueLength : Int = 0
    @State var documentId : String = ""
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Spacer()
                Text("Butik: \(shopName)")
                    .foregroundColor(Color("Text"))
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
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            verifyUser()
        }
    }
    
    private func nextCustomer() {
        let newQueueNumber = currentQueueNumber + 1
        do {
            _ = try db.collection("users").document(documentId).updateData(["currentQueueNumber" : newQueueNumber]
            )
        }
    }
    
    private func verifyUser() {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            let email = user.email
            print("loggedin user: \(uid) \(email!)")
            
            let docRef = db.collection("users").whereField("uid", isEqualTo: uid)
            docRef.getDocuments { (QuerySnapshot, error) in
                if let error = error {
                    print(error)
                    return
                } else if QuerySnapshot!.documents.count != 1 {
                    print("More than 1 document or none")
                } else {
                    let document = QuerySnapshot!.documents.first
                    let dataDescription = document?.data()
                    guard let shopNameDB = dataDescription?["shopName"]
                    else {
                        return
                    }
                    guard let currentQueueDB = dataDescription?["currentQueueNumber"]
                    else {
                        return
                    }
                    guard let highestQueueDB = dataDescription?["highestQueueNumber"]
                    else {
                        return
                    }
                    shopName = "\(shopNameDB)"
                    currentQueueNumber = currentQueueDB as! Int
                    highestQueueNumber = highestQueueDB as! Int
                    queueLength = highestQueueNumber - currentQueueNumber
                    documentId = document!.documentID
                    
                }
            }
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    print("Document data: \(document)")
//                } else {
//                    print("Document does not exist")
//                }
//            }
        }
    }
    
}


//struct QueueView_Previews: PreviewProvider {
//    static var previews: some View {
//        QueueView()
//            .environment(\.colorScheme, .dark)
//    }
//}
