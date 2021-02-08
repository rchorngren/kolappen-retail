//
//  QueueScreen.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-08.
//

import SwiftUI
import Firebase

struct QueueView: View {
    
    var body: some View {
        ZStack {
            Text("Hello from queueview")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
            }
        .onAppear() {
            verifyUser()
        }
    }
    
    private func verifyUser() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            print("loggedin user: \(uid) \(email!)")
        }
    }
    
}


struct QueueView_Previews: PreviewProvider {
    static var previews: some View {
        QueueView()
            .environment(\.colorScheme, .dark)
    }
}
