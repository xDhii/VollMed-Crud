//
//  LoadingView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 31/03/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ZStack {
                Color(.gray)
                    .ignoresSafeArea()
                    .opacity(0.8)

                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .frame(maxWidth: 250, maxHeight: 200)
                    .foregroundStyle(.white)

                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0, anchor: .center)
                        .padding()

                    Text("Carregando...")
                        .font(.title)
                        .bold()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}
