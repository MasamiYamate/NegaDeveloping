//
//  NegaDeveloping.swift
//  NegaDeveloping
//
//  Created by MasamiYamate on 2020/12/18.
//

import UIKit

public final class NegaDeveloping {
    
    private let filterUseCase: ToneCurveFilterUseCase
    
    public init() {
        filterUseCase = ToneCurveFilterUseCase()
    }

    /// Perform development processing
    /// - Parameters:
    ///   - image: Negative Image
    ///   - redChannel: Red channel tone curve points
    ///   - greenChannel: Green channel tone curve points
    ///   - blueChannel: Blue channel tone curve points
    /// - Returns: Positive Image
    public func develop(
        with image: UIImage,
        redChannel: ToneCurvePointsModel,
        greenChannel: ToneCurvePointsModel,
        blueChannel: ToneCurvePointsModel) -> UIImage? {
        
        let ciContext:CIContext = CIContext(options: nil)
        guard
            let ciNegaImage: CIImage = CIImage(image: image),
            let ciPositiveImage: CIImage = develop(
                with: ciNegaImage,
                redChannel: redChannel,
                greenChannel: greenChannel,
                blueChannel: blueChannel),
            let cgPositiveImage: CGImage = ciContext.createCGImage(
                ciPositiveImage,
                from: ciPositiveImage.extent) else {

            return nil
        }

        return UIImage(cgImage: cgPositiveImage, scale: 1.0, orientation: image.imageOrientation)
    }

    /// Perform development processing
    /// - Parameters:
    ///   - image: Negative Image
    ///   - redChannel: Red channel tone curve points
    ///   - greenChannel: Green channel tone curve points
    ///   - blueChannel: Blue channel tone curve points
    /// - Returns: Positive Image
    public func develop(
        with image: CIImage,
        redChannel: ToneCurvePointsModel,
        greenChannel: ToneCurvePointsModel,
        blueChannel: ToneCurvePointsModel) -> CIImage? {
        
        guard
            let reverseImage = filterUseCase.reverse(with: image),
            let positiveImage = filterUseCase.rgbCompositing(
                with: reverseImage,
                redChannel: redChannel,
                greenChannel: greenChannel,
                blueChannel: blueChannel) else {
            return nil
        }

        return positiveImage
    }

}
