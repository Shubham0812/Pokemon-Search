//
//  FoundationExtensions.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import Foundation

extension Int {
    func asString() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
