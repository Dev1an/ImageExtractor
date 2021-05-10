# ImageExtractor

A zero* dependency swift library to extract images from PDFs on macOS.

*only uses macOS system libraries (Quartz) but no third party tools.

## Swift usage

Add this package to the dependencies in your `Package.swift` file.
```swift
.package(url: "https://github.com/Dev1an/ImageExtractor", from: .branch("main")),
```

## Command line usage

A minimal command line tool is also included in the source code. Note that command line tool does have dependencies ;)

Here is how to use it using [mint](https://github.com/yonaskolb/Mint)
```sh
mint run Dev1an/ImageExtractor@main
```
