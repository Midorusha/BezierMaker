//
//  BezAction.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import Foundation

enum BezAction: String {
    case Move = "MoveTo"
    case AddLine = "AddLineTo"
    case AddCurve = "AddCurveTo"
    case AddQuadraticCurve = "AddQuadCurveTo"
    case AddArc = "AddArcWith"
    case Close = "ClosePath"
    
    func spaceRequired() -> Int {
        switch (self) {
        case .Move:
            fallthrough
        case .AddLine:
            return 2
        case .AddCurve:
            return 6
        case .AddQuadraticCurve:
            return 4
        case .AddArc:
            return 6
        case .Close:
            return 0
        }
    }
}

