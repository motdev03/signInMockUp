//
//  String+Extensions.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import Foundation

extension String {
    /// formats the phone number string in default US format ie (XXX) XXX-XXXX
    func formatPhoneNumber(mask: String = "(XXX) XXX-XXXX") -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator9897
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    /// Returns a string containing just the digits after removing all the formatting.
    /// This calls `formatPhoneNumber` internally.
    var unformattedPhoneNumber: String { self.formatPhoneNumber(mask: "XXXXXXXXXX") }
    
    /// Validates if the phone number has exactly ten digits.
    var validPhonenumber: Bool {
        return self.unformattedPhoneNumber.count == 10
    }
}
