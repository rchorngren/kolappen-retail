//
//  SupportView.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-01.
//

import SwiftUI

struct SupportView: View {
    
    var body: some View {
        ZStack {
            Text("Hello from support")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
        
    }
    
}


struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
            .environment(\.colorScheme, .dark)
    }
}
