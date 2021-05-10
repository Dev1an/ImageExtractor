import XCTest
@testable import ImageExtractor
import Quartz

final class ImageExtractorTests: XCTestCase {
    func testSamplePDF() throws {
		guard let sampleURL = Bundle.module.url(forResource: "sample", withExtension: "pdf"),
			  let samplePDF = PDFDocument(url: sampleURL) else {
			XCTFail("Unable to load sample PDF")
			return
		}

		var imageCount = 0
		try extractImages(from: samplePDF) { (image, page, name) in
			print(image, page, name)
			imageCount += 1
		}

		XCTAssertEqual(imageCount, 1)
    }

    static var allTests = [
        ("testSamplePDF", testSamplePDF),
    ]
}
