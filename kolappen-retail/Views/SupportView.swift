//
//  SupportView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-01.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SupportView: View {
    
    @State var contactPhone : String = ""
    @State var contactEmail : String = ""

    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
                VStack {
                    Text("Kölappen")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("Text"))
                    Text("Support")
                        .font(.title2)
                        .foregroundColor(Color("Text"))
                        Spacer()
                    Text("Kontakta oss:")
                        .font(.title3)
                        .padding()
                    Text("Telefon: \(contactPhone)")
                        .foregroundColor(Color("Text"))
                    Text("E-post: \(contactEmail)")
                        .foregroundColor(Color("Text"))
                    Spacer()
                }
                
            }
        .onAppear() {
            getContactInfo()
        }
    }
    
    private func getContactInfo() {
        db.collection("contactInformation").document("contact").getDocument { (document, error) in
            
            let result = Result {
                  try document?.data(as: Contact.self)
                }
                switch result {
                case .success(let contact):
                    if let contact = contact {
                        contactPhone = contact.phone
                        contactEmail = contact.email
                    } else {
                        print("Document does not exist")
                    }
                case .failure(let error):
                    // A `City` value could not be initialized from the DocumentSnapshot.
                    print("Error decoding city: \(error)")
                }
            
//                if let document = document, document.exists {
//                    let dataDescription = document.data()?.description
//                    print("Document data: \(dataDescription)")
//                } else {
//                    print("Document does not exist")
//                }
        }
    }
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SupportView()
//            .environment(\.colorScheme, .dark)
//    }
//}
