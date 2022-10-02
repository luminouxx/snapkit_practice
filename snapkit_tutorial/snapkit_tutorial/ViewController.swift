//
//  ViewController.swift
//  snapkit_tutorial
//
//  Created by YeongJin Jeong on 2022/10/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // 레이아웃 확인용 View 들
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

    // Action을 살펴 볼 버튼
    lazy var myButton = { (color: UIColor) -> UIButton in
        let btn = UIButton(type: .system)
        btn.backgroundColor = color
        btn.setTitle("my Button", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 16
        return btn
    }

    var greenBoxTopNSLayoutConstraint: NSLayoutConstraint? = nil

    // MARK: 4. SnapKit에서의 Layout 변경을 위한 변수 선언
    var greenBoxTopConstraint: Constraint? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let myDarkGrayButton = myButton(.darkGray)
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(blueBox)
        self.view.addSubview(myDarkGrayButton)



        // ******************************************************************
        // MARK: 1. 기존의 Auto Layout과 Snapkit의 Padding 처리
        // ******************************************************************
        //
        // -------------------------------------------------------------------
        // 기존의 Auto Layout Code -> constraints 수정
        // -------------------------------------------------------------------
        //
        //         yellowBox.translatesAutoresizingMaskIntoConstraints = false
        //         yellowBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        //         yellowBox.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        //         yellowBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        //         yellowBox.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        //
        // -------------------------------------------------------------------
        // SnapKit -> inset & outset을 통해 수정이 가능
        // -------------------------------------------------------------------

        yellowBox.snp.makeConstraints { make in
            // Equal to SuperView
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }



        // ******************************************************************
        // MARK: 2. 기존의 Auto Layout -> NSLayoutConstraint 호출 -> Snapkit 으로
        // ******************************************************************

        // -------------------------------------------------------------------
        // 기존의 Auto Layout Code -> constraint(equalTo:, multiplier:) 호출
        // -------------------------------------------------------------------

        //        redBox.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            redBox.widthAnchor.constraint(equalToConstant: 100),
        //            redBox.heightAnchor.constraint(equalToConstant: 100)
        //        ])

        // -------------------------------------------------------------------
        // SnapKit을 사용한 코드
        // -------------------------------------------------------------------

        redBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }




        // ******************************************************************
        // MARK: 3. multiplier 활용하기 snapkit -> multipliedBy, DividedBy
        // ******************************************************************

        // -------------------------------------------------------------------
        // 기존의 Auto Layout Code -> constraint(equalTo:, multiplier:) 호출
        // -------------------------------------------------------------------

        //        blueBox.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            blueBox.widthAnchor.constraint(equalTo: self.redBox.widthAnchor, multiplier: 2.0),
        //            blueBox.heightAnchor.constraint(equalTo: self.redBox.heightAnchor),
        //            blueBox.topAnchor.constraint(equalTo: self.redBox.bottomAnchor, constant: 20),
        //            blueBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        //        ])



        // -------------------------------------------------------------------
        // Snapkit을 사용한 코드 -> multipliedBy & dividedBy 메서드 호출
        // -------------------------------------------------------------------
        blueBox.snp.makeConstraints { make in
            make.width.equalTo(redBox.snp.width).multipliedBy(2) // multipliedBy 호출로 쉽게 조절 가능
            make.height.equalTo(redBox.snp.height)
            make.top.equalTo(redBox.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        // ******************************************************************
        // MARK: 4. LayOut의 변경을 처리해 봅시다. -> GreenBox 옮기기
        // ******************************************************************

        //        greenBox.translatesAutoresizingMaskIntoConstraints = false
        //
        //        greenBoxTopNSLayoutConstraint = greenBox.topAnchor.constraint(equalTo: self.blueBox.bottomAnchor,constant: 20)
        //
        //        NSLayoutConstraint.activate([
        //            greenBox.widthAnchor.constraint(equalToConstant: 100),
        //            greenBox.heightAnchor.constraint(equalToConstant: 100),
        //            greenBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        //        ])
        //
        //        greenBoxTopNSLayoutConstraint?.isActive = true

        greenBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            self.greenBoxTopConstraint = make.top.equalTo(blueBox.snp.bottom).offset(20).constraint
        }



        myDarkGrayButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }

        myDarkGrayButton.addTarget(self, action: #selector(moveGreenBoxDown), for: .touchUpInside)

    }

    var offset = 0
    @objc private func moveGreenBoxDown() {
        print("viewController - moveGreenBoxDown() called / offset: \(offset)")
        offset += 40

        self.greenBoxTopConstraint?.update(offset: offset)
        //        self.greenBoxTopNSLayoutConstraint?.constant = CGFloat(offset)
        UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
}


//  ******************************************************************
//  UIKit에서 Preview를 사용하는 방법 -> 아래의 코드를 추가한 후
//  cmd + opt + Enter -> Preview 생성
//  cmd + opt + p -> Preview 사용가능
//  ******************************************************************


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
