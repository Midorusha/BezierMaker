//
//  BezGraphicalNode.swift
//  Bezieye
//
//  Created by Christopher Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import UIKit

class BezGraphicalNode: CAShapeLayer {
    var next: BezGraphicalNode?
    var pathPair: BezierPair
    var controlPoints: [BezControlPoint]
    init(pathPair _pathPair: BezierPair, next _next: BezGraphicalNode?) {
        pathPair = _pathPair
        next = _next
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BezGraphicalPath: CAShapeLayer {
    var bezierPath: UIBezierPath
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BezEndPoint: CAShapeLayer {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BezControlPoint: CAShapeLayer {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}