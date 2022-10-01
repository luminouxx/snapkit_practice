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
    }()

    lazy var yellowBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    lazy var redBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    lazy var blueBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(blueBox)

//        yellowBox.translatesAutoresizingMaskIntoConstraints = false
//        greenBox.translatesAutoresizingMaskIntoConstraints = false
//        redBox.translatesAutoresizingMaskIntoConstraints = false
//        blueBox.translatesAutoresizingMaskIntoConstraints = false

        // 기존 오토레이아웃
//        yellowBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        yellowBox.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        yellowBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
//        yellowBox.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true

        // SnapKit
        yellowBox.snp.makeConstraints { make in
//            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            // Equal to SuperView
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))

        }

        redBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
//            make.center.equalToSuperview()
        }

        // 기존의 코드
//        redBox.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            redBox.widthAnchor.constraint(equalToConstant: 100),
//            redBox.heightAnchor.constraint(equalToConstant: 100)
//        ])

        blueBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(redBox.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }


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
