//
//  ViewController.swift
//  AZToast
//
//  Created by minkook on 10/25/2022.
//  Copyright (c) 2022 minkook. All rights reserved.
//

import UIKit
import AZToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: Button Action
extension ViewController {
    
    @IBAction func defaultButtonAction(_ sender: Any) {
        AZToastConfig.shared.theme = AZToastTheme_Default()
        AZToast(text: "토스트 입니다.").show()
    }
    
    @IBAction func custom1ButtonAction(_ sender: Any) {
        AZToastConfig.shared.theme = AZToastTheme_Custom1()
        AZToast(text: """
        슬라이드 토스트 입니다.
        두번째 입니다.
        세번째 입니다.
        """).show()
    }
    
    @IBAction func custom2ButtonAction(_ sender: Any) {
        AZToastConfig.shared.theme = AZToastTheme_Custom2()
        AZToast(text: "팝 토스트 입니다.").duration(3.0).show()
    }
    
    @IBAction func custom3ButtonAction(_ sender: Any) {
        AZToastConfig.shared.theme = AZToastTheme_Custom2()
        AZToast(text: "매우 긴 토스트를 작성 할 것입니다. 그래서 애국가를 적어보았습니다. 그럼 시작하겠습니다. 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리 나라 만세. 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.").duration(5.0).show()
    }
    
    @IBAction func custom4ButtonAction(_ sender: Any) {
        AZToastConfig.shared.theme = AZToastTheme_Custom3()
        AZToast(text: "돌아라 토스트").show()
    }
}


struct AZToastTheme_Custom1: AZToastTheme {
    var duration: TimeInterval = 1.5
    
    var animateDuration: TimeInterval = 0.3
    
    var animateType: AZToastThemeAnimate = .slide
    
    var backgroundColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
    
    var borderWidth: Double = 1.0
    
    var borderColor: UIColor = .black
    
    var cornerRadius: Double = 5.0
    
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    var textColor: UIColor = .white
    
    var textAlignment: NSTextAlignment = .center
    
    var lineSpacing: Double = 5.0
    
    var icon: AZToastThemeIcon? = .init(image: UIImage(systemName: "heart"),
                                        size: CGSize(width: 32, height: 32),
                                        alignment: .left,
                                        textSpacing: 10.0)
    
    init() { }
}

struct AZToastTheme_Custom2: AZToastTheme {
    var duration: TimeInterval = 1.5

    var animateDuration: TimeInterval = 0.3

    var animateType: AZToastThemeAnimate = .pop

    var backgroundColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)

    var borderWidth: Double = 1.0

    var borderColor: UIColor = .black

    var cornerRadius: Double = 5.0

    var font: UIFont = UIFont.systemFont(ofSize: 16)

    var textColor: UIColor = .white

    var textAlignment: NSTextAlignment = .center

    var lineSpacing: Double = 5.0

    var icon: AZToastThemeIcon? = .init(image: UIImage(systemName: "heart"),
                                        size: CGSize(width: 64, height: 64),
                                        alignment: .top,
                                        textSpacing: 10.0)

    init() { }
}

struct AZToastTheme_Custom3: AZToastTheme {
    var duration: TimeInterval = 3.0
    
    var animateDuration: TimeInterval = 1.3
    
    var animateType: AZToastThemeAnimate = .samD
    
    var backgroundColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
    
    var borderWidth: Double = 1.0
    
    var borderColor: UIColor = .black
    
    var cornerRadius: Double = 5.0
    
    var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    var textColor: UIColor = .white
    
    var textAlignment: NSTextAlignment = .center
    
    var lineSpacing: Double = 5.0
    
    var icon: AZToastThemeIcon? = .init(image: UIImage(systemName: "heart"),
                                        size: CGSize(width: 32, height: 32),
                                        alignment: .left,
                                        textSpacing: 10.0)
    
    init() { }
}
