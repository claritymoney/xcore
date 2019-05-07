//
// UIButton+Styles.swift
//
// Copyright © 2018 Zeeshan Mian
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

// MARK: Main Button Styles

extension XCConfiguration where Type: UIButton {
    public static var none: XCConfiguration {
        return XCConfiguration(identifier: "none") { _ in }
    }

    public static func checkbox(normalColor: UIColor, selectedColor: UIColor, textColor: UIColor, font: UIFont) -> XCConfiguration {
        return XCConfiguration(identifier: "checkbox") {
            $0.accessibilityIdentifier = "checkboxButton"
            $0.textColor = textColor
            $0.titleLabel?.font = font
            $0.titleLabel?.numberOfLines = 0
            $0.textImageSpacing = .minimumPadding
            $0.contentHorizontalAlignment = .left
            $0.adjustsImageWhenHighlighted = false
            $0.adjustsBackgroundColorWhenHighlighted = false
            $0.highlightedBackgroundColor = .clear
            $0.highlightedAnimation = .none
            $0.contentEdgeInsets = 0

            let unfilledImage = UIImage(assetIdentifier: .checkmarkIconUnfilled)
            let filledImage = UIImage(assetIdentifier: .checkmarkIconFilled)
            $0.setImage(unfilledImage.tintColor(normalColor), for: .normal)
            $0.setImage(filledImage.tintColor(selectedColor), for: .selected)
        }
    }

    public static func radioButton(selectedColor: UIColor, borderColor: UIColor, borderWidth: CGFloat = 0.5) -> XCConfiguration {
        return XCConfiguration(identifier: "radioButton") {
            let outerWidth: CGFloat = 20

            $0.accessibilityIdentifier = "radioButton"
            $0.layer.borderWidth = borderWidth
            $0.layer.borderColor = borderColor.cgColor
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = outerWidth / 2

            $0.anchor.make {
                $0.size.equalTo(outerWidth)
            }

            let scale: CGFloat = 0.15
            $0.image = UIImage()
            let inset = outerWidth * scale
            $0.imageView?.cornerRadius = (outerWidth - inset * 2) / 2

            $0.imageView?.anchor.make {
                $0.edges.equalToSuperview().inset(inset)
            }

            $0.didSelect { sender in
                sender.imageView?.backgroundColor = sender.isSelected ? selectedColor : .clear
            }
        }
    }
}
