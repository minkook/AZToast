//
//  AZToastView.swift
//  AZToast
//
//  Created by minkook yoo on 2022/10/25.
//

import Foundation

final class AZToastView: UIView {
    
    private let contentView = UIView()
    private let textLabel = UILabel()
    private var iconImageView: UIImageView?
    
    private let text: String
    private var theme: AZToastTheme { AZToastConfig.shared.theme }
    private var inset: UIEdgeInsets { AZToastConfig.shared.inset }
    private var contentInset: UIEdgeInsets { AZToastConfig.shared.contentInset }
    
    init(frame: CGRect, text: String) {
        self.text = text
        super.init(frame: frame)
        setUpView()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(duration: TimeInterval) {
        animate_show()
        
        perform(#selector(didFinish), with: nil, afterDelay: duration)
    }
    
    func hide() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(didFinish), object: nil)
        removeFromSuperview()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if (view.hitTest(convert(point, to: view), with: event) != nil) {
                return true
            }
        }
        return false
    }
}

fileprivate extension AZToastView {
    
    @objc func didFinish() {
        animate_hide()
    }
}

fileprivate extension AZToastView {
    func setUpView() {
        contentView.backgroundColor = theme.backgroundColor
        contentView.layer.borderWidth = theme.borderWidth
        contentView.layer.borderColor = theme.borderColor.cgColor
        contentView.layer.cornerRadius = theme.cornerRadius
        addSubview(contentView)
        
        textLabel.numberOfLines = 0
        textLabel.attributedText = NSAttributedString(string: text).lineSpacing(spacing: theme.lineSpacing)
        textLabel.font = theme.font
        textLabel.textColor = theme.textColor
        textLabel.textAlignment = theme.textAlignment
        contentView.addSubview(textLabel)
        
        if let icon = theme.icon {
            let imageView = UIImageView(image: icon.image)
            contentView.addSubview(imageView)
            iconImageView = imageView
        }
    }
    
    func layoutViews() {
        var thatSize = bounds.size
        thatSize.width -= (inset.left + inset.right)
        thatSize.width -= (contentInset.left + contentInset.right)
        
        if let icon = theme.icon {
            switch icon.alignment {
            case .left, .left_top, .left_bottom, .right:
                thatSize.width -= (icon.size.width + icon.textSpacing)
            default:
                break
            }
        }
        
        let textSize = textLabel.sizeThatFits(thatSize)
        
        if theme.icon != nil {
            layoutContentViewsWithIcon(textSize)
        } else {
            layoutContentViews(textSize)
        }
    }
    
    func layoutContentViews(_ textSize: CGSize) {
        let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
        
        let w = textSize.width + (contentInset.left + contentInset.right)
        let h = textSize.height + (contentInset.top + contentInset.bottom)
        let x = bounds.midX - (w / 2)
        let y = bounds.maxY - safeAreaBottom - (h + inset.bottom)
        contentView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        textLabel.frame = CGRect(origin: .init(x: contentInset.left, y: contentInset.top), size: textSize)
    }
    
    func layoutContentViewsWithIcon(_ textSize: CGSize) {
        guard let icon = theme.icon else { return }
        guard let iconImageView = iconImageView else { return }
        
        let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
        
        // 컨텐츠 뷰
        switch icon.alignment {
        case .left,
                .left_top,
                .left_bottom,
                .right,
                .right_top,
                .right_bottom:
            let w = textSize.width + (contentInset.left + contentInset.right) + (icon.size.width + icon.textSpacing)
            let h = max(textSize.height, icon.size.height) + (contentInset.top + contentInset.bottom)
            let x = bounds.midX - (w / 2)
            let y = bounds.maxY - safeAreaBottom - (h + inset.bottom)
            contentView.frame = CGRect(x: x, y: y, width: w, height: h)
        case .top,
                .top_left,
                .top_right,
                .bottom,
                .bottom_left,
                .bottom_right:
            let w = max(textSize.width, icon.size.width) + (contentInset.left + contentInset.right)
            let h = textSize.height + (contentInset.top + contentInset.bottom) + (icon.size.height + icon.textSpacing)
            let x = bounds.midX - (w / 2)
            let y = bounds.maxY - safeAreaBottom - (h + inset.bottom)
            contentView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        // 아이콘
        let x_l = contentView.bounds.minX + contentInset.left
        let x_m = contentView.bounds.midX - (icon.size.width/2)
        let x_r = contentView.bounds.maxX - (contentInset.right + icon.size.width)
        let y_t = contentView.bounds.minY + contentInset.top
        let y_m = contentView.bounds.midY - (icon.size.height/2)
        let y_b = contentView.bounds.maxY - (contentInset.bottom + icon.size.height)
        switch icon.alignment {
        case .left:
            iconImageView.frame = CGRect(origin: .init(x: x_l, y: y_m), size: icon.size)
        case .left_top:
            iconImageView.frame = CGRect(origin: .init(x: x_l, y: y_t), size: icon.size)
        case .left_bottom:
            iconImageView.frame = CGRect(origin: .init(x: x_l, y: y_b), size: icon.size)
        case .right:
            iconImageView.frame = CGRect(origin: .init(x: x_r, y: y_m), size: icon.size)
        case .right_top:
            iconImageView.frame = CGRect(origin: .init(x: x_r, y: y_t), size: icon.size)
        case .right_bottom:
            iconImageView.frame = CGRect(origin: .init(x: x_r, y: y_b), size: icon.size)
        case .top:
            iconImageView.frame = CGRect(origin: .init(x: x_m, y: y_t), size: icon.size)
        case .top_left:
            iconImageView.frame = CGRect(origin: .init(x: x_l, y: y_t), size: icon.size)
        case .top_right:
            iconImageView.frame = CGRect(origin: .init(x: x_r, y: y_t), size: icon.size)
        case .bottom:
            iconImageView.frame = CGRect(origin: .init(x: x_m, y: y_b), size: icon.size)
        case .bottom_left:
            iconImageView.frame = CGRect(origin: .init(x: x_l, y: y_b), size: icon.size)
        case .bottom_right:
            iconImageView.frame = CGRect(origin: .init(x: x_r, y: y_b), size: icon.size)
        }
        
        // 텍스트
        switch icon.alignment {
        case .left,
                .left_top,
                .left_bottom:
            let x = iconImageView.frame.maxX + icon.textSpacing
            let y = contentView.bounds.midY - (textSize.height/2)
            textLabel.frame = CGRect(origin: .init(x: x, y: y), size: textSize)
        case .right,
                .right_top,
                .right_bottom:
            let x = contentView.bounds.minX + contentInset.left
            let y = contentView.bounds.midY - (textSize.height/2)
            textLabel.frame = CGRect(origin: .init(x: x, y: y), size: textSize)
        case .top,
                .top_left,
                .top_right:
            let x = contentView.bounds.midX - (textSize.width/2)
            let y = contentView.bounds.maxY - (contentInset.bottom + textSize.height)
            textLabel.frame = CGRect(origin: .init(x: x, y: y), size: textSize)
        case .bottom,
                .bottom_left,
                .bottom_right:
            let x = contentView.bounds.midX - (textSize.width/2)
            let y = contentView.bounds.minY + contentInset.top
            textLabel.frame = CGRect(origin: .init(x: x, y: y), size: textSize)
        }
    }
}

fileprivate extension AZToastView {
    func animate_show() {
        switch theme.animateType {
        case .fade:
            self.contentView.alpha = 0.0
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.alpha = 1.0
            }
        case .slide:
            self.contentView.transform = CGAffineTransformMakeTranslation(bounds.width, 0)
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.transform = .identity
            }
        case .pop:
            self.contentView.transform = CGAffineTransformMakeTranslation(0, bounds.height)
            UIView.animate(withDuration: theme.animateDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.5) {
                self.contentView.transform = .identity
            }
        case .scale:
            self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2)
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.transform = .identity
            }
        case .samD:
            if #available(iOS 13.0, *) {
                let duration = theme.animateDuration
                var count = Int(duration * 10)
                if count % 2 != 0 { count += 1 }
                self.contentView.alpha = 0.0
                UIView.animateKeyframes(withDuration: duration, delay: 0) {
                    for i in 0..<count {
                        let st = Double(Double(i) / 10.0)
                        let d = Double(Double(i+1) / 10.0)
                        let transform = (i % 2 == 0) ? CATransform3DMakeRotation(.pi, 0, 1, 0) : CATransform3DIdentity
                        UIView.addKeyframe(withRelativeStartTime: st, relativeDuration: d) {
                            self.contentView.transform3D = transform
                        }
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: duration) {
                        self.contentView.alpha = 1.0
                    }
                }
            } else {
                self.contentView.alpha = 0.0
                UIView.animate(withDuration: theme.animateDuration) {
                    self.contentView.alpha = 1.0
                }
            }
        }
    }
    
    func animate_hide() {
        switch theme.animateType {
        case .fade:
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.alpha = 0.0
            } completion: { _ in
                self.removeFromSuperview()
            }
        case .slide:
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.transform = CGAffineTransformMakeTranslation(-self.bounds.width, 0)
            } completion: { _ in
                self.removeFromSuperview()
            }
        case .pop:
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.transform = CGAffineTransformMakeTranslation(0, self.bounds.height)
            } completion: { _ in
                self.removeFromSuperview()
            }
        case .scale:
            UIView.animate(withDuration: theme.animateDuration) {
                self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01)
            } completion: { _ in
                self.removeFromSuperview()
            }
        case .samD:
            if #available(iOS 13.0, *) {
                UIView.animate(withDuration: theme.animateDuration) {
                    self.contentView.transform3D = CATransform3DMakeRotation(.pi, 0, 1, 0)
                    self.contentView.alpha = 0.0
                } completion: { _ in
                    self.removeFromSuperview()
                }
            } else {
                UIView.animate(withDuration: theme.animateDuration) {
                    self.contentView.alpha = 0.0
                } completion: { _ in
                    self.removeFromSuperview()
                }
            }
        }
    }
}

// MARK: -
fileprivate extension NSAttributedString {
    func lineSpacing(spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: string.count))
        return attributedString
    }
}
