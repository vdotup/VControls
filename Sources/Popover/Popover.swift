//
//  SwiftUIView.swift
//  
//
//  Created by Abdurrahman Alfudeghi on 20/01/2022.
//

import SwiftUI

extension View {
    public func popup
    <T: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> T) -> some View {
        return self
            .background(PopupHelper(content: content(), isPresented: isPresented, onDismiss: onDismiss))
    }
}

struct PopupHelper<T: View>: UIViewControllerRepresentable {
    
    var content: T
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)?
    
    let controller = UIViewController()
    //var hostingController: UIHostingController<T>!
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        //controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            var hostingController = UIHostingController(rootView: content)
            //hostingController.view.backgroundColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.5)
            controller.view.addSubview(hostingController.view)
            controller.addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
            hostingController.view.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
            guard let window = UIApplication.shared.keyWindow else { return }
            guard let rootVC = window.rootViewController else { return }
            rootVC.view.addSubview(controller.view)
            rootVC.addChild(controller)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                controller.view.removeFromSuperview()
//                //controller.parent?.removeFromParent()
//            }
        } else {
            guard let window = UIApplication.shared.keyWindow else { return }
            guard let rootVC = window.rootViewController else { return }
            controller.view.removeFromSuperview()
            controller.parent?.removeFromParent()
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: PopupHelper
        
        init(parent: PopupHelper) {
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

class PopupHostingController<T: View>: UIHostingController<T> {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
//        if let presentationController = presentationController as? UISheetPresentationController {
//            presentationController.detents = [.medium(), .large()]
//            presentationController.prefersGrabberVisible = true
//        }
    }
}
