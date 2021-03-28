//
//  NativeView.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 26/03/21.
//

import SwiftUI
import GoogleMobileAds

struct NativeView: View {
    
    let adUnit: AdUnit = .native
    @State var adStatus: AdStatus = .loading
    
    var nativeViewController = NativeViewController2(adUnit: .native)
    
    var body: some View {
        VStack {
            Text("Status Ads: \(adStatus == AdStatus.loading ? "Loading Ads" : adStatus == AdStatus.success ? "Success Load Ads" : adStatus == AdStatus.failure ? "Unable to Load Ads" : "Ads has dismissed")")
            
            if adStatus == .success {
                NativeAdView(nativeAd: nativeViewController.nativeAds()!)
                    .background(Color.gray.opacity(0.2))
                    .frame(maxWidth: 375)
            }
            
        }.frame(maxWidth: .infinity)
        .onAppear {
            nativeViewController.loadAd(adStatus: $adStatus)
        }
    }
}

struct NativeAdView: View {
    
    var nativeAd: GADNativeAd
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Ad")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .background(Color.yellow)
                
                Spacer()
            }
            
            HStack {
                Image(uiImage: (nativeAd.icon?.image)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text(nativeAd.headline!)
                    Text(nativeAd.advertiser ?? "Advert")
                }
                Spacer()
            }
            
            Text(nativeAd.body!)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            
            VStack {
                NativeMediaView(mediaView: nativeAd.mediaContent)
                    .aspectRatio(CGSize(width: 250, height: 150), contentMode: .fit)
                    .frame(width: 250, height: 150)
            }.frame(width: 250, height: 150)
            
        }.frame(maxWidth: 375)
    }
}

final class NativeMediaView: UIViewRepresentable {
    
    var mediaView: GADMediaContent
    
    init(mediaView: GADMediaContent){
        self.mediaView = mediaView
    }
    
    typealias UIViewType = GADMediaView
    
    func makeUIView(context: Context) -> GADMediaView {
        let view = GADMediaView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: GADMediaView, context: Context) {
        uiView.mediaContent = self.mediaView
        uiView.frame(forAlignmentRect: CGRect(origin: .zero, size: CGSize(width: 250, height: 150)))
    }
}
