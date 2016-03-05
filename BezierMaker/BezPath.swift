//
//  BezPath.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import UIKit


func g() {
    if let currentPath = BezHistory.getCurrentBezPath() {
        let currentElements = currentPath.getBezierPairs()
        
        // create linked list of bezpairs (UIBezierPath, BezPathElement)
        var lastNode: BezGraphicalNode? = nil
        var curNode: BezGraphicalNode? = nil
        for element in currentElements.reverse() {
            curNode = BezGraphicalNode(pathPair: element, next: lastNode)
            lastNode = curNode
        }
    }
}

typealias BezierPair = (UIBezierPath, BezPathElement)

struct BezPath {
    var actions: [BezAction]
    var values: [CGFloat]
    
    init() {
        actions = [BezAction]()
        values = [CGFloat]()
    }
    
    init(elements: BezPathElement...) {
        self.init()
        // TODO: May have to sort on BezPathElement.sourceIndex
        actions.reserveCapacity(elements.count)
        for e in elements {
            actions.append(e.action)
            values.appendContentsOf(e.values)
        }
    }
    
    mutating func addAction(action: BezAction, floats: CGFloat...) {
        guard action.spaceRequired() == floats.count else {
            assertionFailure("Incorrect number of values")
            return
        }
        actions.append(action)
        values.appendContentsOf(floats)
    }
    
    func getFullUIBezierPath() -> UIBezierPath {
        let p = UIBezierPath()
        var valuesIndex = 0
        for action in actions {
            applyAction(action, path: p, atIndex: valuesIndex)
            valuesIndex += action.spaceRequired()
        }
        return p
    }
    
    func getBezierPairs() -> [BezierPair] {
        var paths = [(UIBezierPath, BezPathElement)]()
        paths.reserveCapacity(actions.count)
        var valuesIndex = 0
        for action in actions {
            let p = UIBezierPath()
            applyAction(action, path: p, atIndex: valuesIndex)
            let element = BezPathElement(
                sourceIndex: valuesIndex,
                action: action,
                values: values[valuesIndex..<action.spaceRequired()])
            paths.append((p, element))
            valuesIndex += action.spaceRequired()
        }
        return paths
    }
}

extension BezPath {
    private func applyAction(action: BezAction, path p: UIBezierPath, atIndex index: Int) {
        switch (action) {
        case .Move:
            moveToPoint(path: p, atIndex: index)
        case .AddLine:
            addLineToPoint(path: p, atIndex: index)
        case .AddCurve:
            addCurveToPoint(path: p, atIndex: index)
        case .AddQuadraticCurve:
            addQuadCurveToPoint(path: p, atIndex: index)
        case .AddArc:
            addArcWithCenter(path: p, atIndex: index)
        case .Close:
            closePath(path: p)
        }
    }
    
    private func moveToPoint(path p: UIBezierPath, atIndex index: Int) {
        p.moveToPoint(CGPoint(x: values[index], y: values[index + 1]))
    }
    
    private func addLineToPoint(path p: UIBezierPath, atIndex index: Int) {
        p.addLineToPoint(CGPoint(x: values[index], y: values[index + 1]))
    }
    
    private func addCurveToPoint(path p: UIBezierPath, atIndex index: Int) {
        let endPoint      = CGPoint(x: values[index],     y: values[index + 1])
        let controlPoint1 = CGPoint(x: values[index + 2], y: values[index + 3])
        let controlPoint2 = CGPoint(x: values[index + 4], y: values[index + 5])
        p.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
    
    private func addQuadCurveToPoint(path p: UIBezierPath, atIndex index: Int) {
        let endPoint      = CGPoint(x: values[index],     y: values[index + 1])
        let controlPoint  = CGPoint(x: values[index + 2], y: values[index + 3])
        p.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
    }
    
    private func addArcWithCenter(path p: UIBezierPath, atIndex index: Int) {
        let center     = CGPoint(x: values[index], y: values[index + 1])
        let radius     = values[index + 2]
        let startAngle = values[index + 3]
        let endAngle   = values[index + 4]
        let clockwise  = values[index + 5].isZero
        p.addArcWithCenter(center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise)
    }
    
    private func closePath(path p: UIBezierPath) {
        p.closePath()
    }
}
