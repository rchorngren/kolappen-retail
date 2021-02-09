//
//  Shop.swift
//  kolappen-retail
//
//  Created by Robert Horngren on 2021-02-09.
//

import Foundation
import FirebaseFirestoreSwift

struct Shop : Codable, Identifiable {
    @DocumentID var id : String?
    var shopName : String
    var currentQueueNumber : Int
    var highestQueueNumber : Int
    var uid : String
}
