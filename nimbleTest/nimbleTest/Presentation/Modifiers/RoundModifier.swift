//
//  RoundModifier.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation
import SwiftUI

extension View {

    /// A SwiftUI modifier that adds a rounded background to a view with an optional border.
    ///
    /// Use the `roundedBackground(_:border:)` modifier to apply a rounded background of a specified color to a
    /// SwiftUI view with an optional border color.
    /// By default, the background color is set to `Colors.backgroundWhite`.
    ///
    /// Example:
    /// ```
    /// Text("Hello, SwiftUI!")
    ///     .roundedBackground(background: .blue, border: .gray)
    /// ```
    ///
    /// - Parameters:
    ///   - background: The color of the rounded background. Defaults to `Colors.backgroundWhite`.
    ///   - border: The color of the optional border. Defaults to `nil`.
    ///   - radius: The corner radius. Defaults to `nil`.
    /// - Returns: A modified view with a rounded background and an optional border.
    func roundedBackground(_ background: Color = Color.white,
                           border: Color? = nil,
                           radius: CGFloat? = nil,
                           lineWidth: CGFloat = 2) -> some View {

        return modifier(RounedBackgroundModifier(background: background,
                                                 border: border,
                                                 radius: radius,
                                                 lineWidth: lineWidth))
    }
}

struct RounedBackgroundModifier: ViewModifier {
    var background: Color
    var border: Color?
    var radius: CGFloat?
    var lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: radius ?? 12)
                    .fill(background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: radius ?? 12)
                    .stroke(border ?? Color.clear, lineWidth: lineWidth)
            )
    }
}
