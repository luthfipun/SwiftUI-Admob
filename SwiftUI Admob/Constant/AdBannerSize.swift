//
//  AdBannerSize.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import Foundation
import GoogleMobileAds

enum AdBannerSize {
    case small
    case large
    case medium
    case adaptive
    
    var adSize: GADAdSize {
        switch self {
        case .small:
            return kGADAdSizeBanner
        case .large:
            return kGADAdSizeLargeBanner
        case .medium:
            return kGADAdSizeMediumRectangle
        case .adaptive:
            return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.size.width)
        }
    }
    
    var size: CGSize {
        adSize.size
    }
}
