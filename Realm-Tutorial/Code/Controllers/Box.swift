//
//  Box.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    
    // MARK:- variables for the binder
    var value: T {
        didSet {
            listener?(value)
        }
    }

    var listener: Listener?
    
    // MARK:- initializers for the binder
    init(_ value: T) {
        self.value = value
    }
    
    // MARK:- functions for the binder
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
