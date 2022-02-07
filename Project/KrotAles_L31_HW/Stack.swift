//
//  Stack.swift
//  KrotAles_L31_HW
//
//  Created by Ales Krot on 7.02.22.
//

import Foundation

struct Stack {
    private var storage: [URL] = []
    
    mutating func push(_ value: URL) {
        storage.append(value)
    }
    
    mutating func pop() -> URL? {
        storage.popLast()
    }
    
    func peek() -> URL? {
        return storage.last
    }
}
