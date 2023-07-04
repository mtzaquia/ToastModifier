# ToastModifier

A simple `SwiftUI` view modifier to present a toast using `UIKit`.

## Instalation

`ToastModifier` is available via Swift Package Manager.

```swift
dependencies: [
  .package(url: "https://github.com/mtzaquia/ToastModifier.git", .upToNextMajor(from: "1.0.0")),
],
```

## Usage

```swift
struct ContentView: View {
	@State var isPresented = false

	// ...

	var body: some View {
		Button(action: { isPresented = true }) {
			Text("Present")
		}
		.toast(isPresented: $isPresented, dismissAfter: 4) {
			MyPresentedView()
		}
	}
}
```

## Credits
Thanks to Kyle Bashour for tips on UIPresentationController. Available [here](https://kylebashour.com/posts/custom-view-controller-presentation-tips)

## License

Copyright (c) 2023 @mtzaquia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
