//
//  BezPathElement.swift
//  Bezieye
//
//  Created by Chris Davis on 2/29/16.
//  Copyright © 2016 The Nerdery. All rights reserved.
//

import UIKit

struct BezPathElement {
    var sourceIndex: Int
    var action: BezAction
    var values: ArraySlice<CGFloat>
}
