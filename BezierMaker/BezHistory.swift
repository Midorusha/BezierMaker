//
//  BezHistory.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import UIKit

class BezHistory {
    private static var undoStack = Stack<BezPath>()
    private static var redoStack = Stack<BezPath>()
    
    static func undo() {
        if let history = undoStack.pop() {
            redoStack.push(history)
        }
    }
    
    static func redo() {
        if let history = redoStack.pop() {
            undoStack.push(history)
        }
    }
    
    static func addToHistory(path: BezPath) {
        redoStack.removeAll()
        undoStack.push(path)
    }
    
    static func getCurrentBezPath() -> BezPath? {
        return undoStack.top()
    }
}