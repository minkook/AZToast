//
//  AZToast.swift
//  AZToast
//
//  Created by minkook yoo on 2022/10/25.
//

import Foundation

open class AZToast {
    
    private let _text: String
    private var _duration: TimeInterval?
    private var tapClosure: (() -> Void)?
    
    @discardableResult
    public init(text: String) {
        _text = text
    }
    
    public func show() {
        _show()
    }
    
    public func duration(_ duration: TimeInterval) -> AZToast {
        _duration = duration
        return self
    }
    
    public func tap(closure: @escaping () -> Void) -> AZToast {
        tapClosure = closure
        return self
    }
}

fileprivate extension AZToast {
    
    func _show() {
        guard let window = UIApplication.shared.windows.first else {
            print("no windows.")
            return
        }
        
        // 이전 Toast 제거.
        removeAll(window)
        
        let view = AZToastView(frame: CGRect(origin: .zero, size: window.bounds.size), text: _text)
        window.addSubview(view)
        
        if let tapClosure = tapClosure {
            view.tap { tapClosure() }
        }
        
        let d = _duration ?? AZToastConfig.shared.theme.duration
        view.show(duration: d)
    }
    
    func removeAll(_ window: UIWindow) {
        let toastViews = window.subviews.filter({ $0 is AZToastView }).map({ $0 as! AZToastView })
        for tv in toastViews {
            tv.hide()
        }
    }
}

open class AZToastConfig {
    static public let shared = AZToastConfig()
    
    /// 디바이스화면 과 뷰 사이 여백
    public let inset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 40, right: 20)
    
    /// 뷰 내부 여백
    public let contentInset: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
    
    /// 테마
    public var theme: AZToastTheme = AZToastTheme_Default()
}
