//
//  NativeViewController.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 26/03/21.
//

import SwiftUI
import GoogleMobileAds

final class NativeViewController: UIViewControllerRepresentable {
    
    let adUnitID: String
    @Binding var adStatus: AdStatus
    
    var adLoader: GADAdLoader?
    
    init(adUnitID: String, adStatus: Binding<AdStatus>){
        self.adUnitID = adUnitID
        self._adStatus = adStatus
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(nativeViewController: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 1
        
        adLoader = GADAdLoader(adUnitID: self.adUnitID, rootViewController: viewController, adTypes: [GADAdLoaderAdType.native], options: [multipleAdsOptions])
        adLoader?.delegate = context.coordinator
        adLoader?.load(GADRequest())
        
        let testLabel = GADNativeAdView()
        viewController.view.addSubview(testLabel)
        
        return viewController
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
        guard let rating = starRating?.doubleValue else {
          return nil
        }
        if rating >= 5 {
          return UIImage(named: "stars_5")
        } else if rating >= 4.5 {
          return UIImage(named: "stars_4_5")
        } else if rating >= 4 {
          return UIImage(named: "stars_4")
        } else if rating >= 3.5 {
          return UIImage(named: "stars_3_5")
        } else {
          return nil
        }
      }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        print("STA => \(self.adStatus)")
        if self.adStatus == .success {
            let nativeAd = context.coordinator.nativeAd
            
            let nativeAdView = GADNativeAdView()
            
            nativeAdView.mediaView?.mediaContent = nativeAd?.mediaContent

            // Populate the native ad view with the native ad assets.
            // The headline is guaranteed to be present in every native ad.
            (nativeAdView.headlineView as? UILabel)?.text = nativeAd?.headline

            // These assets are not guaranteed to be present. Check that they are before
            // showing or hiding them.
            (nativeAdView.bodyView as? UILabel)?.text = nativeAd?.body
            nativeAdView.bodyView?.isHidden = nativeAd?.body == nil

            (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd?.callToAction, for: .normal)
            nativeAdView.callToActionView?.isHidden = nativeAd?.callToAction == nil

            (nativeAdView.iconView as? UIImageView)?.image = nativeAd?.icon?.image
            nativeAdView.iconView?.isHidden = nativeAd?.icon == nil

            (nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(from:nativeAd?.starRating)
            nativeAdView.starRatingView?.isHidden = nativeAd?.starRating == nil

            (nativeAdView.storeView as? UILabel)?.text = nativeAd?.store
            nativeAdView.storeView?.isHidden = nativeAd?.store == nil

            (nativeAdView.priceView as? UILabel)?.text = nativeAd?.price
            nativeAdView.priceView?.isHidden = nativeAd?.price == nil

            (nativeAdView.advertiserView as? UILabel)?.text = nativeAd?.advertiser
            nativeAdView.advertiserView?.isHidden = nativeAd?.advertiser == nil

            // In order for the SDK to process touch events properly, user interaction
            // should be disabled.
            nativeAdView.callToActionView?.isUserInteractionEnabled = false

            // Associate the native ad view with the native ad object. This is
            // required to make the ad clickable.
            // Note: this should always be done after populating the ad views.
            nativeAdView.nativeAd = nativeAd
            nativeAdView.translatesAutoresizingMaskIntoConstraints = false
            
            uiViewController.removeFromParent()
            uiViewController.view.addSubview(nativeAdView)
        }
        
    }
    
    class Coordinator: NSObject, GADNativeAdLoaderDelegate {
        
        var nativeViewController: NativeViewController
        var nativeAd: GADNativeAd?
        
        init(nativeViewController: NativeViewController){
            self.nativeViewController = nativeViewController
        }
        
        func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
            self.nativeAd = nativeAd
            self.nativeViewController.adStatus = .success
        }
        
        func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
            self.nativeViewController.adStatus = .failure
        }
    }
}
