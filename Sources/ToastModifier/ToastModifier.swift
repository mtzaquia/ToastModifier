//  Copyright (c) 2023 @mtzaquia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI
import UIKitPresentationModifier

public extension View {
    /// **[ToastModifier]** Use this modifier to present an ephemeral toast which may auto-dismiss and won't block interactions
    /// with the presenting view.
    ///
    /// - Important: The toast view won't inherit custom values from the presentation's environment,
    /// so those need to be manually provided again as needed.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to the presentation.
    ///   - edgeInsets: The padding to be applied to the toast. It will be appended to the safe area. Defaults to `16`
    ///   on `[.bottom, .horizontal]`.
    ///   - dismissAfter: The amount of seconds before the toast is auto-dismissed. If zero or less, the toast does
    ///   not auto-dismiss. Defaults to `.zero`.
    ///   - content: The content to be displayed inside the bottom sheet.
    func toast<Toast>(
        isPresented: Binding<Bool>,
        edgeInsets: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16),
        dismissAfter: Int = .zero,
        @ViewBuilder toast: @escaping () -> Toast
    ) -> some View where Toast: View {
        modifier(
            _ToastModifier(
                isPresented: isPresented,
                edgeInsets: edgeInsets,
                dismissAfter: dismissAfter,
                toast: toast
            )
        )
    }
}

private struct _ToastModifier<Toast: View>: ViewModifier {
    init(
        isPresented: Binding<Bool>,
        edgeInsets: EdgeInsets,
        dismissAfter: Int,
        toast: @escaping () -> Toast
    ) {
        _isPresented = isPresented
        self.edgeInsets = edgeInsets
        self.dismissAfter = dismissAfter
        self.toast = toast
    }

    @Binding var isPresented: Bool
    let edgeInsets: EdgeInsets
    let dismissAfter: Int
    let toast: () -> Toast

    func body(content: Content) -> some View {
        content
            .presentation(isPresented: $isPresented) {
                toast()
                    .onAppear {
                        if dismissAfter > 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(dismissAfter)) {
                                isPresented = false
                            }
                        }
                    }
            } controllerProvider: { toast in
                ToastHostingController(
                    edgeInsets: edgeInsets,
                    rootView: toast
                )
            }
    }
}
