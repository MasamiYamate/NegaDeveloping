//
//  ToneCurveFilterUseCase.swift
//  NegaDeveloping
//
//  Created by MasamiYamate on 2020/12/18.
//

import UIKit

/// Tone curve filters
final class ToneCurveFilterUseCase {
    
    /// Tone Reverse
    /// - Parameter image: base image
    /// - Returns: filtered image
    func reverse(with image: CIImage) -> CIImage? {
        return image.applyingFilter(
            "CIToneCurve",
            parameters: [
                "inputPoint0": CIVector(x: 0.0, y: 1.0),
                "inputPoint1": CIVector(x: 0.25, y: 0.75),
                "inputPoint2": CIVector(x: 0.5, y: 0.5),
                "inputPoint3": CIVector(x: 0.75, y: 0.25),
                "inputPoint4": CIVector(x: 1.0, y: 0.0)
            ])
    }
    
    func rgbCompositing(
        with image: CIImage,
        redChannel: ToneCurvePointsModel,
        greenChannel: ToneCurvePointsModel,
        blueChannel: ToneCurvePointsModel) -> CIImage? {

        let redImage = image.applyingFilter(
            "CIToneCurve",
            parameters: [
                "inputPoint0": redChannel.pointZero,
                "inputPoint1": redChannel.pointOne,
                "inputPoint2": redChannel.pointTwo,
                "inputPoint3": redChannel.pointThree,
                "inputPoint4": redChannel.pointFour
            ])
        let greenImage = image.applyingFilter(
            "CIToneCurve",
            parameters: [
                "inputPoint0": greenChannel.pointZero,
                "inputPoint1": greenChannel.pointOne,
                "inputPoint2": greenChannel.pointTwo,
                "inputPoint3": greenChannel.pointThree,
                "inputPoint4": greenChannel.pointFour
            ])
        let blueImage = image.applyingFilter(
            "CIToneCurve",
            parameters: [
                "inputPoint0": blueChannel.pointZero,
                "inputPoint1": blueChannel.pointOne,
                "inputPoint2": blueChannel.pointTwo,
                "inputPoint3": blueChannel.pointThree,
                "inputPoint4": blueChannel.pointFour
            ])
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "default", ofType: "metallib") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        
        guard
            let data = try? Data(contentsOf: url),
            let rgbChannelCompositingKernel = try? CIColorKernel(functionName: "rgbChannelCompositing", fromMetalLibraryData: data) else {
            return nil
        }

        let extent = redImage.extent.union(greenImage.extent.union(blueImage.extent))
        let arguments = [redImage, greenImage, blueImage]

        guard let ciImage = rgbChannelCompositingKernel.apply(extent: extent, arguments: arguments) else {
            return nil
        }
        return ciImage

    }

}
