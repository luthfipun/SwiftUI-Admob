//
//  InterstitialView.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import SwiftUI

struct InterstitialView: View {
    
    @State var adStatus: AdStatus = .loading
    var interstitialAds = InterstitialViewController()
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Status Ads: \(adStatus == AdStatus.loading ? "Loading Ads" : adStatus == AdStatus.success ? "Success Load Ads" : adStatus == AdStatus.failure ? "Unable to Load Ads" : "Ads has dismissed")")
            
            Button(action: {
                interstitialAds.showAd()
            }, label: {
                Text("Tap to show insterstitial Ads")
            }).disabled(adStatus == .loading || adStatus == .dismiss)
        }.onAppear {
            interstitialAds.loadAds(adUnit: .interstitial, adStatus: $adStatus)
        }
    }
}
