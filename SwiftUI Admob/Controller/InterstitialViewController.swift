//
//  InterstitialViewController.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import Foundation
import GoogleMobileAds
import SwiftUI

final class InterstitialViewController: NSObject, GADFullScreenContentDelegate {
    
    var adUnit: AdUnit = .interstitial
    @Binding var adStatus: AdStatus
    var interstitialAds: GADInterstitialAd?
    
    init(adStatus: Binding<AdStatus> = .constant(AdStatus.loading)) {
        self._adStatus = adStatus
    }
    
    
    func loadAds(adUnit: AdUnit, adStatus: Binding<AdStatus>) {
        self.adUnit = adUnit
        self._adStatus = adStatus
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adUnit.unitID, request: request) { interstitialAds, error in
            
            if error != nil {
                print("Failed to load interstitial ads \(String(describing: error?.localizedDescription))")
                self.adStatus = .failure
                return
            }
            
            self.adStatus = .success
            self.interstitialAds = interstitialAds
            self.interstitialAds?.fullScreenContentDelegate = self
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.adStatus = .failure
        print("Ad did fail to present full screen content.")
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.adStatus = .dismiss
        print("Ad did dismiss full screen content.")
    }
    
    func showAd() {
        if interstitialAds != nil {
            let root = UIApplication.shared.windows.first?.rootViewController
            interstitialAds?.present(fromRootViewController: root!)
        }
    }
}
