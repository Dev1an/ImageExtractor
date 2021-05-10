import XCTest
@testable import ImageExtractor

final class ImageExtractorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ImageExtractor().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
