//
//  BezGraphicalNode.swift
//  Bezieye
//
//  Created by Christopher Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import UIKit

class BZShapeLayer: CAShapeLayer {
    init(parentLayer: CALayer) {
        super.init()
        parentLayer.addSublayer(self)
        frame = parentLayer.bounds
        contentsScale = UIScreen.mainScreen().scale
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BezGraphicalNode: BZShapeLayer {
    var next: BezGraphicalNode?
    var pathPair: BezierPair
    var graphicaPath: BezGraphicalPath
    var endPoint: BezEndPoint
    var controlPoints: [BezControlPoint]
    
    init(pathPair _pathPair: BezierPair, parentLayer: CALayer) {
        super.init(parentLayer: parentLayer)
        pathPair = _pathPair
        
        switch (pathPair.1.action) {
        case .Move:
            // create dot
            var point = CGPoint.zero
            memccpy(&point, &pathPair.1.values, sizeof(CGPoint))
            memcpy(&point, Array(pathPair.1.values), sizeof(CGPoint))
            endPoint = BezEndPoint(center: point, parentLayer: self)
        case .AddLine:
            // create endpoint
            // create line
        case .AddCurve:
            // create endpoint
            // create controlpoint1
            // create controlpoint2
            // create line
        case .AddQuadraticCurve:
            // create endpoint
            // create controlpoint
            // create line
        case .AddArc:
            // create endpoint
            // create controlpoint center
            // create line
        case .Close:
            // create line to beginning
            // hmmm so i need the first line
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Actual Bezier Path Line
class BezGraphicalPath: BZShapeLayer {
    static var strokeColor: CGColorRef = UIColor.redColor().CGColor
    static var fillColor: CGColorRef = UIColor.clearColor().CGColor
    var bezierPath: UIBezierPath
    
    init(bezierPath _bezierPath: UIBezierPath, parentLayer: CALayer) {
        super.init(parentLayer: parentLayer)
        bezierPath = _bezierPath
        path = CGPathCreateCopy(_bezierPath.CGPath)
        strokeColor = BezGraphicalPath.strokeColor
        fillColor = BezGraphicalPath.fillColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BZDotLayer: BZShapeLayer {
    private init(center: CGPoint, radius: CGFloat, color: CGColorRef, parentLayer: CALayer) {
        super.init(parentLayer: parentLayer)
        frame = CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: center.x + radius,
            height: center.y + radius)
        backgroundColor = BezControlPoint.pointColor
        cornerRadius = radius * 0.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///  End Point Dot
class BezEndPoint: BZDotLayer {
    static var pointSize: CGFloat = 5.0
    static var pointColor: CGColorRef = UIColor.grayColor().CGColor
    
    init(center: CGPoint, parentLayer: CALayer) {
        super.init(
            center: center,
            radius: BezEndPoint.pointSize,
            color: BezEndPoint.pointColor,
            parentLayer: parentLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Control Point Dot
class BezControlPoint: BZDotLayer {
    static var pointSize: CGFloat = 5.0
    static var pointColor: CGColorRef = UIColor.blueColor().CGColor
    
    init(center: CGPoint, parentLayer: CALayer) {
        super.init(center: center,
            radius: BezControlPoint.pointSize,
            color: BezControlPoint.pointColor,
            parentLayer: parentLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}