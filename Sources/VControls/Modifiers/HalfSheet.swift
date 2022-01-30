//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 17/01/2022.
//

import SwiftUI

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

extension View {
    public func halfSheet
    <T: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> T) -> some View {
        return self
            .background(HalfSheetHelper(sheet: content(), isPresented: isPresented, onDismiss: onDismiss))
    }
}

struct HalfSheetHelper<T: View>: UIViewControllerRepresentable {
    
    var sheet: T
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)?
    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        //controller.view.backgroundColor = .clear
        controller.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(context.coordinator.handleTap)))
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let sheetController = CustomHostingController(rootView: sheet)
            guard let window = UIApplication.shared.keyWindow else { return }
            guard let rootVC = window.rootViewController else { return }
            rootVC.present(sheetController, animated: true)
            sheetController.presentationController?.delegate = context.coordinator
        } else {
            guard let window = UIApplication.shared.keyWindow else { return }
            guard let rootVC = window.rootViewController else { return }
            rootVC.dismiss(animated: true)
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
            if let dismiss = parent.onDismiss {
                dismiss()
            }
        }
        
        @objc func handleTap() {
            parent.isPresented.toggle()
        }
    }
}

class CustomHostingController<T: View>: UIHostingController<T> {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }
    }
}
