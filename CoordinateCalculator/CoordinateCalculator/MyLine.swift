//
//  MyLine.swift
//  CoordinateCalculator
//
//  Created by YOUTH on 2017. 11. 23..
//  Copyright © 2017년 Codesquad Inc. All rights reserved.
//

import Foundation

struct MyLine {
    var pointA = MyPoint(x: 0, y: 0)
    var pointB = MyPoint(x: 0, y: 0)
}

extension MyLine: MyShape, Equatable {

    func getMyPoints() -> [(Int,Int)] {
        let myPoints = [(x: pointA.x, y: pointA.y),
                        (x: pointB.x, y: pointB.y)]
        return myPoints
    }
    
    static func isValidShape(_ myPoints: [MyPoint]) -> Bool {
        if myPoints[0] == myPoints[1] {
            return false
        }
        return true
    }

    static func == (lineA: MyLine, lineB: MyLine) -> Bool {
        return (lineA.pointA == lineB.pointA && lineA.pointB == lineB.pointB)
    }
    
}

extension MyLine: ResultByShape {

    func calculate() -> Double {
        let subtractX = (pointA.x - pointB.x).magnitude
        let subtractY = (pointA.y - pointB.y).magnitude
        let cal = Double(subtractX^2 + subtractY^2)
        let distance = sqrt(cal)
        return distance
    }

    func messageByShape() -> String {
        return "두 점 사이의 거리는? -> "
    }
    
    
}
