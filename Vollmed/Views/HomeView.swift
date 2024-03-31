//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    let service = WebService()
    @State private var specialists: [Specialist] = []

    func getSpecialists() async {
        do {
            if let specialists = try await service.getAllSpecialists() {
                self.specialists = specialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.vertical, 32)
                    Text("Boas-vindas!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(.lightBlue))
                    Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.accent)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    ForEach(specialists) { specialist in
                        SpecialistCardView(specialist: specialist)
                            .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .onAppear {
                Task {
                    await getSpecialists()
                }
            }
        }

        // MARK: - Logout Buttom

        .safeAreaInset(
            edge: .top,
            alignment: .trailing,
            content: {
                Button(
                    action: {
                        UserDefaultsHelper.remove(for: "token")
                        UserDefaultsHelper.remove(for: "patient-id")

                    }, label: {
                        Text("Logout")
                            .bold()
                            .foregroundStyle(.cancel)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                )
            }
        )
    }
}

#Preview {
    HomeView()
}
