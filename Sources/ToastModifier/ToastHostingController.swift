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

public final class ToastHostingController<Content: View>: UIHostingController<Content> {
    private let edgeInsets: EdgeInsets

    public init(edgeInsets: EdgeInsets, rootView: Content) {
        self.edgeInsets = edgeInsets
        super.init(rootView: rootView)
        modalPresentationStyle = .custom
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) { fatalError() }

    public override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
        get { ToastTransitioningDelegate(edgeInsets: NSDirectionalEdgeInsets(edgeInsets)) }
        set {}
    }
}

final class ToastTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    init(edgeInsets: NSDirectionalEdgeInsets) {
        self.edgeInsets = edgeInsets
        super.init()
    }

    let edgeInsets: NSDirectionalEdgeInsets

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        ToastPresentationController(
            presentedViewController: presented,
            presenting: presenting,
            source: source,
            edgeInsets: edgeInsets
        )
    }

//    func animationController(
//        forPresented presented: UIViewController,
//        presenting: UIViewController,
//        source: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        ToastAnimator(action: .present)
//    }
//
//    func animationController(
//        forDismissed dismissed: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        ToastAnimator(action: .dismiss)
//    }
}
