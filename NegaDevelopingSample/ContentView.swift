//
//  ContentView.swift
//  NegaDevelopingSample
//
//  Created by MasamiYamate on 2020/12/19.
//

import SwiftUI
import NegaDeveloping

struct ContentView: View {

    private let negaDeveloping = NegaDeveloping()

    private let redToneCurveModel = ToneCurvePointsModel(
        pointZero: CIVector(x: 0.0, y: 0.0),
        pointOne: CIVector(x: 0.38, y: 0.07),
        pointTwo: CIVector(x: 0.63, y: 0.24),
        pointThree: CIVector(x: 0.78, y: 0.49),
        pointFour: CIVector(x: 1.0, y: 1.0))
    
    private let greenToneCurveModel = ToneCurvePointsModel(
        pointZero: CIVector(x: 0.0, y: 0.0),
        pointOne: CIVector(x: 0.67, y: 0.07),
        pointTwo: CIVector(x: 0.85, y: 0.19),
        pointThree: CIVector(x: 0.92, y: 0.39),
        pointFour: CIVector(x: 1.0, y: 0.90))
    
    private let blueToneCurveModel = ToneCurvePointsModel(
        pointZero: CIVector(x: 0.0, y: 0.0),
        pointOne: CIVector(x: 0.69, y: 0.06),
        pointTwo: CIVector(x: 0.90, y: 0.20),
        pointThree: CIVector(x: 0.96, y: 0.44),
        pointFour: CIVector(x: 1.0, y: 0.92))
    
    
    private var positiveImage = UIImage()
    
    init() {
        guard
            let negaImage = UIImage(named: "nega_sample"),
            let positiveImage = negaDeveloping.develop(
                with: negaImage,
                redChannel: redToneCurveModel,
                greenChannel: greenToneCurveModel,
                blueChannel: blueToneCurveModel) else {
            
            return
        }
        self.positiveImage = positiveImage
    }

    var body: some View {
        Image(uiImage: positiveImage)
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
