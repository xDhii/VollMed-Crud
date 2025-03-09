//
//  SpecialistCardView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI
import VollmedUI

struct SpecialistCardView: View {
    // MARK: - Attributes

    var specialist: Specialist
    var appointment: Appointment?
    let service = WebService()
    @State private var specialistImage: UIImage?
    @State private var showTooltip: Bool = false

    // MARK: - Body

    func downloadImage() async {
        do {
            if let image = try await service.downloadImage(from: specialist.imageUrl) {
                specialistImage = image
            }
        } catch {
            print("Ocorreu um erro ao obter a imagem: \(error)")
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                if let specialistImage {
                    Image(uiImage: specialistImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                } else {
                    Image(.doctor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }

                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                        Text(specialist.name)
                            .font(.title3)
                            .bold()

                        Button {
                            showTooltip.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        .iOSPopover(
                            isPresented: $showTooltip,
                            arrowDirection: .any) {
                                VollmedTooltipView(title: "Disponível", description: "Agende sua consulta.")
                        }
                    }
                    Text(specialist.specialty)
                    if let appointment {
                        Text(appointment.date.convertDateStringToReadableDate())
                            .bold()
                    }
                }
            }
            if let appointment {
                HStack {
                    NavigationLink {
                        ScheduleAppointmentView(specialistID: specialist.id, isRescheduleView: true, appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Remarcar")
                    }

                    NavigationLink {
                        CancelAppointmentView(appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Cancelar", buttonType: .cancel)
                    }
                }
            } else {
                NavigationLink {
                    ScheduleAppointmentView(specialistID: specialist.id)
                } label: {
                    ButtonView(text: "Agendar consulta")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .onAppear {
            Task {
                await downloadImage()
            }
        }
    }
}

#Preview {
    SpecialistCardView(specialist:
        Specialist(id: "c84k5kf",
                   name: "Dr. Carlos Alberto",
                   crm: "123456",
                   imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                   specialty: "Neurologia",
                   email: "carlos.alberto@example.com",
                   phoneNumber: "(11) 99999-9999")
    )
}

extension View {
    func iOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirection: UIPopoverArrowDirection, content: @escaping () -> Content) -> some View {
        self.background {
            PopOverController(isPresented: isPresented, content: content(), arrowDirection: arrowDirection)
        }
    }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable {
    // MARK: - Attributes

    @Binding var isPresented: Bool
    var content: Content
    var arrowDirection: UIPopoverArrowDirection

    // MARK: - Body

    func makeUIViewController(context _: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let controller = CustomHostingView(rootView: content)

            controller.view.backgroundColor = .clear
            controller.modalPresentationStyle = .popover
            controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
            controller.presentationController?.delegate = context.coordinator
            controller.popoverPresentationController?.sourceView = uiViewController.view

            uiViewController.present(controller, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        let parent: PopOverController

        init(parent: PopOverController) {
            self.parent = parent
        }

        func adaptivePresentationStyle(for _: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }

        func presentationControllerWillDismiss(
            _: UIPresentationController
        ) {
            parent.isPresented = false
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        preferredContentSize = view.intrinsicContentSize
    }
}
