//
//  ViewController.swift
//  snapkit_tutorial
//
//  Created by YeongJin Jeong on 2022/10/01.
//

import UIKit

class ViewController: UIViewController {

    lazy var greenBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .green 
        return view


    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}



#if DEBUG

import SwiftUI
struct ViewControllerReperesentable: UIViewControllerRepresentable {


    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // empty
    }

    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
}
@available(iOS 13.0.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerReperesentable()
                .ignoresSafeArea()
                .previewDisplayName("Preview")
                .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        }
    }
}
#endif
