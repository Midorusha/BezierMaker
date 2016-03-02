//
//  PrintableObject.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

protocol Printable {
    func printEntity()
}

extension BezPath: Printable {
    func printEntity() {
        print("")
        var valuesIndex = 0
        for action in actions {
            printAction(action, atIndex: valuesIndex)
            valuesIndex += action.spaceRequired()
        }
    }
    
    private func printAction(action: BezAction, atIndex index: Int) {
        switch (action) {
        case .Move:
            print("\t<\(BezAction.Move.rawValue) {\(values[index]), \(values[index + 1])}>")
        case .AddLine:
            print("\t<\(BezAction.AddLine.rawValue) {\(values[index]), \(values[index + 1])}>")
        case .AddCurve:
            print("\t<\(BezAction.AddCurve.rawValue) {\(values[index]), \(values[index + 1])} {\(values[index + 2]), \(values[index + 3])} {\(values[index + 4]), \(values[index + 5])}>")
        case .AddQuadraticCurve:
            print("\t<\(BezAction.AddQuadraticCurve.rawValue) {\(values[index]), \(values[index + 1])} {\(values[index + 2]), \(values[index + 3])}>")
        case .AddArc:
            print("\t<\(BezAction.AddArc.rawValue) {\(values[index]), \(values[index + 1])} \(values[index + 2]) \(values[index + 3]) \(values[index + 4]) \(values[index + 5].isZero)>")
        case .Close:
            print("\t<\(BezAction.Close.rawValue)>")
        }
    }
}
