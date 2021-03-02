//
//  SupportView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-01.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SupportView: View {
    
    @State var contactPhone : String = ""
    @State var contactEmail : String = ""

    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("Background")
            VStack {
                Spacer()
                Text("Kontakta oss:")
                    .font(.title3)
                    .foregroundColor(Color("Text"))
                    .padding()
                HStack {
                    Spacer()
                    VStack {
                        Text("Telefon:")
                            .foregroundColor(Color("Text"))
                            .padding(.bottom)
                        Text("E-post:")
                            .foregroundColor(Color("Text"))
                    }
                    VStack (alignment: .leading) {
                        Text("\(contactPhone)")
                            .foregroundColor(Color("Text"))
                            .padding(.bottom)
                        Text("\(contactEmail)")
                            .foregroundColor(Color("Text"))
                    }
                    Spacer()
                }
                Spacer()
            }
            .navigationBarTitle("Support")
        }
        .ignoresSafeArea()
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
                    print("Error decoding document: \(error)")
                }

        }
    }
    
}



//struct SupportView_Previews: PreviewProvider {
//    static var previews: some View {
//        SupportView()
//            .environment(\.colorScheme, .dark)
//    }
//}
