//
//  Item.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
