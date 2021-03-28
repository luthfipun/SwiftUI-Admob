//
//  NativeViewController2.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 26/03/21.
//

import Foundation
import SwiftUI
import GoogleMobileAds

final class NativeViewController2: NSObject, GADNativeAdLoaderDelegate {
    
    let adUnit: AdUnit
    @Binding var adStatus: AdStatus
    
    var adLoader: GADAdLoader?
    var nativeAd: GADNativeAd?
    
    init(adUnit: AdUnit, adStatus: Binding<AdStatus> = .constant(AdStatus.loading)){
        self.adUnit = adUnit
        self._adStatus = adStatus
    }
    
    func loadAd(adStatus: Binding<AdStatus>){
        self._adStatus = adStatus
        
        let options = GADNativeAdMediaAdLoaderOptions()
        options.mediaAspectRatio = .square
        
        let root = UIApplication.shared.windows.first?.rootViewController
        
        adLoader = GADAdLoader(adUnitID: adUnit.unitID, rootViewController: root!, adTypes: [GADAdLoaderAdType.native], options: [options])
        adLoader?.delegate = self
        adLoader?.load(GADRequest())
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        self.nativeAd = nativeAd
        self.adStatus = .success
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        self.adStatus = .failure
    }
    
    func nativeAds() -> GADNativeAd? {
        self.nativeAd
    }
}
