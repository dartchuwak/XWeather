//
//  LottieView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 29.01.2026.
//

import SwiftUI
import Lottie

struct LottieLoaderView: View {
    var body: some View {
        VStack {
            LottieView(animation: .named("loader"))
                .playing()
                .looping()
        }
    }
}

#Preview {
    LottieView(animation: .named("loader"))
        .playing()
        .looping()
}
