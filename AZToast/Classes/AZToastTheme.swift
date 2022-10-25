//
//  AZToastTheme.swift
//  AZToast
//
//  Created by minkook yoo on 2022/10/25.
//

import Foundation

public protocol AZToastTheme {
    /// 유지시간
    var duration: TimeInterval { get }
    
    /// 애니메이션 시간
    var animateDuration: TimeInterval { get }
    
    /// 애니메이션 종류
    var animateType: AZToastThemeAnimate { get }
    
    /// 배경색
    var backgroundColor: UIColor { get }
    
    /// 외곽선 크기
    var borderWidth: Double { get }
    
    /// 외곽선 색
    var borderColor: UIColor { get }
    
    /// 뷰 끝부분 radius
    var cornerRadius: Double { get }
    
    /// 글꼴
    var font: UIFont { get }
    
    /// 글자색
    var textColor: UIColor { get }
    
    /// 글자 정렬
    var textAlignment: NSTextAlignment { get }
    
    /// 글자 엔터사이 간격
    var lineSpacing: Double { get }
    
    /// 아이콘
    var icon: AZToastThemeIcon? { get }
}

public enum AZToastThemeAnimate {
    case fade
    case slide
    case pop
    case scale
}

public struct AZToastThemeIcon {
    public var image: UIImage?
    public var size: CGSize
    public var alignment: IconAlignment
    public var textSpacing: Double
    
    //
    //                          +---------+      +-----+      +----------+
    //                          |top_left |      | top |      |top_right |
    //                          +---------+      +-----+      +----------+
    //                               |              |              |
    //                               |              |              |
    //                     +---------+--------------+--------------+------------+
    //      +---------+    |         |              |              |            |     +----------+
    //      |left_top |----+->       v              v              v          <-+-----|right_top |
    //      +---------+    |                                                    |     +----------+
    //                     |    +------------------------------------------+    |
    //          +-----+    |    |                                          |    |     +------+
    //          |left |----+->  |               Message Text               |  <-+-----|right |
    //          +-----+    |    |                                          |    |     +------+
    //                     |    +------------------------------------------+    |
    //   +------------+    |                                                    |     +-------------+
    //   |left_bottom |----+->        ^             ^              ^          <-+-----|right_bottom |
    //   +------------+    |          |             |              |            |     +-------------+
    //                     +----------+-------------+--------------+------------+
    //                                |             |              |
    //                                |             |              |
    //                          +------------+  +--------+  +-------------+
    //                          |bottom_left |  | bootom |  |bottom_right |
    //                          +------------+  +--------+  +-------------+
    //
    public enum IconAlignment {
        case left, left_top, left_bottom
        case right, right_top, right_bottom
        case top, top_left, top_right
        case bottom, bottom_left, bottom_right
    }
    
    public init(image: UIImage?, size: CGSize, alignment: IconAlignment, textSpacing: Double) {
        self.image = image
        self.size = size
        self.alignment = alignment
        self.textSpacing = textSpacing
    }
}

public struct AZToastTheme_Default: AZToastTheme {
    public var duration: TimeInterval = 1.5
    
    public var animateDuration: TimeInterval = 0.3
    
    public var animateType: AZToastThemeAnimate = .fade
    
    public var backgroundColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
    
    public var borderWidth: Double = 1.0
    
    public var borderColor: UIColor = .black
    
    public var cornerRadius: Double = 5.0
    
    public var font: UIFont = UIFont.systemFont(ofSize: 16)
    
    public var textColor: UIColor = .white
    
    public var textAlignment: NSTextAlignment = .center
    
    public var lineSpacing: Double = 5.0
    
    public var icon: AZToastThemeIcon? = nil
    
    public init() { }
}
