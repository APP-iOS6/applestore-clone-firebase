//
//  UserID.swift
//  ApplePark
//
//  Created by Soom on 10/7/24.
//

import Foundation

struct UserID: Identifiable {
    var id: UUID = UUID()
    var item: Item
    var order: Order
}
