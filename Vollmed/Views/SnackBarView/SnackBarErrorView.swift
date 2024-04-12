//
//  SnackBarErrorView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 11/04/24.
//

import SwiftUI

struct SnackBarErrorView: View {
    @Binding var isShowing: Bool
    var message: String

    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .padding()
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, isShowing ? UIApplication.shared.getKeyWindow?.safeAreaInsets.bottom ?? 0 : -100)
    }
}

#Preview {
    SnackBarErrorView(isShowing: .constant(true), message: "Não foi possível retornar a lista de especialistas")
}
