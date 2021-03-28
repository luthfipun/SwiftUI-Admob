//
//  AdUnit.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import Foundation

enum AdUnit {
    case banner
    case interstitial
    case native
    case reward
    case rewardInterstitial
    case appOpen
    
    var unitID: String {
        switch self {
        case .banner:
            return "ca-app-pub-3940256099942544/2934735716"
        case .interstitial:
            return "ca-app-pub-3940256099942544/4411468910"
        case .native:
            return "ca-app-pub-3940256099942544/3986624511"
        case .reward:
            return "ca-app-pub-3940256099942544/1712485313"
        case .rewardInterstitial:
            return "ca-app-pub-3940256099942544/6978759866"
        case .appOpen:
            return "ca-app-pub-3940256099942544/5662855259"
        }
    }
}
