//
//  BannerView.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import SwiftUI

struct BannerView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("Content Here \n Banner ads will show at the bottom")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            AdBannerView(adUnit: .banner, adSize: .small)
        }
    }
}

struct AdBannerView: View {
    let adUnit: AdUnit
    let adSize: AdBannerSize
    @State var adStatus: AdStatus = .loading
    
    var body: some View {
        HStack {
            if adStatus != .failure {
                BannerViewController(adUnitID: adUnit.unitID, adSize: adSize.adSize, adStatus: $adStatus)
                    .frame(width: adSize.size.width, height: adSize.size.height)
            }
        }.frame(maxWidth: .infinity)
    }
}
