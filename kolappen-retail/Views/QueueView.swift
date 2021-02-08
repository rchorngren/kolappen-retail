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
    
    var body: some View {
        ZStack {
            Text("Butik: \(shopName)")
                .foregroundColor(Color("Text"))
                
            }
        .onAppear() {
            verifyUser()
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
                    shopName = "\(shopNameDB)"
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


struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
            .environment(\.colorScheme, .dark)
    }
}
