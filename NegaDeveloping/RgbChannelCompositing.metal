//
//  RgbChannelCompositing.metal
//  NegaDeveloping
//
//  Created by MasamiYamate on 2020/12/18.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>
extern "C" {
    namespace coreimage {
        float4 rgbChannelCompositing(sample_t red, sample_t green, sample_t blue) {
            return float4(red.r, green.g, blue.b, 1.0);
        }
    }
}
