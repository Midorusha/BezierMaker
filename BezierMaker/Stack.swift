//
//  Stack.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import Foundation

struct Stack<Element> {
    private var contents: Array<Element>
    
    init() {
        contents = Array<Element>()
    }
    
    func isEmpty() -> Bool {
        return contents.count > 0
    }
    
    mutating func removeAll() {
        contents.removeAll()
    }
    
    func size() -> Int {
        return contents.count
    }
    
    func top() -> Element? {
        return contents.last
    }
    
    mutating func push(element: Element) {
        contents.append(element)
    }
    
    mutating func pop() -> Element? {
        return contents.popLast()
    }
}


