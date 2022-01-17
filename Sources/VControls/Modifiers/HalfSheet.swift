//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 17/01/2022.
//

import SwiftUI

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
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let sheetController = CustomHostingController(rootView: sheet)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
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
