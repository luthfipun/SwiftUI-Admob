//
//  ContentView.swift
//  SwiftUI Admob
//
//  Created by Luthfi Abdul Azis on 25/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: BannerView(), tag: 1, selection: $selection) {
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Text("Banner Ads")
                    })
                }
                
                NavigationLink(destination: InterstitialView(), tag: 2, selection: $selection){
                    Button(action: {
                        self.selection = 2
                    }, label: {
                        Text("Interstitial Ads")
                    })
                }
                
//                NavigationLink(destination: NativeView(), tag: 3, selection: $selection){
//                    Button(action: {
//                        self.selection = 3
//                    }, label: {
//                        Text("Native Ads")
//                    })
//                }
                
            }
            .navigationTitle("Admob")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
