//
//  ToneCurvePointsModel.swift
//  NegaDeveloping
//
//  Created by MasamiYamate on 2020/12/18.
//

import UIKit

/// Tone curve points
public struct ToneCurvePointsModel {

    /// inputPoint0
    public let pointZero: CIVector

    /// inputPoint1
    public let pointOne: CIVector

    /// inputPoint2
    public let pointTwo: CIVector

    /// inputPoint3
    public let pointThree: CIVector

    /// inputPoint4
    public let pointFour: CIVector

    public init(
        pointZero: CIVector,
        pointOne: CIVector,
        pointTwo: CIVector,
        pointThree: CIVector,
        pointFour: CIVector) {
        
        self.pointZero = pointZero
        self.pointOne = pointOne
        self.pointTwo = pointTwo
        self.pointThree = pointThree
        self.pointFour = pointFour

    }
}
