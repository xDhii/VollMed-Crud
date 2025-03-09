//
//  VollmedTextStylesUI.swift
//  Pods
//
//  Created by Adriano Valumin on 04/03/25.
//

import SwiftUI

struct VollmedTextStylesUI: View {
    let boldColor = Color(
        red: 0.0 / 255.0,
        green: 33.0 / 255.0,
        blue: 61.0 / 255.0,
        opacity: 1.0
    )

    var body: some View {
        VStack {
            Text("Title L Regular")
                .titleStyleLRegular()

            Text("Title L Bold")
                .titleStyleLBold()

            Text("Title Md Redular")
                .titleStyleMdRegular()

            Text("Title Md Bold")
                .titleStyleMdBold()

            Text("Title S Regular")
                .titleStyleSRegular()

            Text("Title S Bold")
                .titleStyleSBold()

            Text("Body Regular")
                .bodyStyleRegular()

            Text("Body Bold")
                .bodyStyleBold()

            Text("Caption")
                .captionStyle()
        }
    }
}

struct TitleStyleLRegular: ViewModifier {
    /// Applies the Large (L) Regular title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 22pt
    /// - Weight: Regular
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with large regular title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .foregroundStyle(.gray)
            .fontWeight(.regular)
    }
}

struct TitleStyleLBold: ViewModifier {
    /// Applies the Large (L) Bold title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 22pt
    /// - Weight: Bold
    /// - Color: Dark blue (RGB: 0, 33, 61; Hex: #00213D)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with large bold title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .foregroundStyle(Color(red: 0.0 / 255.0, green: 33.0 / 255.0, blue: 61.0 / 255.0))
            .fontWeight(.bold)
    }
}

struct TitleStyleMdRegular: ViewModifier {
    /// Applies the Medium (MD) Regular title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 20pt
    /// - Weight: Regular
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with medium regular title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundStyle(.gray)
            .fontWeight(.regular)
    }
}

struct TitleStyleMdBold: ViewModifier {
    /// Applies the Medium (MD) Bold title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 20pt
    /// - Weight: Bold
    /// - Color: Dark blue (RGB: 0, 33, 61; Hex: #00213D)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with medium bold title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundStyle(Color(red: 0.0 / 255.0, green: 33.0 / 255.0, blue: 61.0 / 255.0))
            .fontWeight(.bold)
    }
}

struct TitleStyleSRegular: ViewModifier {
    /// Applies the Small (S) Regular title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 18pt
    /// - Weight: Regular
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with small regular title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .foregroundStyle(.gray)
            .fontWeight(.regular)
    }
}

struct TitleStyleSBold: ViewModifier {
    /// Applies the Small (S) Bold title style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 18pt
    /// - Weight: Bold
    /// - Color: Dark blue (RGB: 0, 33, 61; Hex: #00213D)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with small bold title styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .foregroundStyle(Color(red: 0.0 / 255.0, green: 33.0 / 255.0, blue: 61.0 / 255.0))
            .fontWeight(.bold)
    }
}

struct BodyStyleRegular: ViewModifier {
    /// Applies the Regular body text style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 17pt
    /// - Weight: Regular
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with regular body styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .foregroundStyle(.gray)
            .fontWeight(.regular)
    }
}

struct BodyStyleBold: ViewModifier {
    /// Applies the Bold body text style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 17pt
    /// - Weight: Bold
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with bold body styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17))
            .foregroundStyle(.gray)
            .fontWeight(.bold)
    }
}

struct CaptionStyle: ViewModifier {
    /// Applies the Caption text style to a Text view.
    ///
    /// Style Attributes:
    /// - Font: System, 14pt
    /// - Weight: Regular
    /// - Color: Gray (default system color)
    /// - Parameter content: The Text view to modify.
    /// - Returns: Modified Text view with caption styling.
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundStyle(.gray)
            .fontWeight(.regular)
    }
}

extension View {
    public func titleStyleLRegular() -> some View {
        modifier(TitleStyleLRegular())
    }

    public func titleStyleLBold() -> some View {
        modifier(TitleStyleLBold())
    }

    public func titleStyleMdRegular() -> some View {
        modifier(TitleStyleMdRegular())
    }

    public func titleStyleMdBold() -> some View {
        modifier(TitleStyleMdBold())
    }

    public func titleStyleSRegular() -> some View {
        modifier(TitleStyleSRegular())
    }

    public func titleStyleSBold() -> some View {
        modifier(TitleStyleSBold())
    }

    public func bodyStyleRegular() -> some View {
        modifier(BodyStyleRegular())
    }

    public func bodyStyleBold() -> some View {
        modifier(BodyStyleBold())
    }

    public func captionStyle() -> some View {
        modifier(CaptionStyle())
    }
}

#Preview {
    VollmedTextStylesUI()
}
