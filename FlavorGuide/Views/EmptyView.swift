//
//  EmptyView.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/10/24.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("emptystate")
                .resizable()
                .frame(width: 140, height: 140)
                .padding(.bottom, 10)
            Text("Nothing to show here yet. This could be because of network connectivity or our servers are unwell.")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

