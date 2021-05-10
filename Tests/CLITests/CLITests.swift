import XCTest
@testable import CommandLineTools

final class CLITests: XCTestCase {
	let samplePath = Bundle.module.url(forResource: "sample", withExtension: "pdf")!.path

	func execute(_ command: String) throws -> (String, String) {
		var outputs = ""
		var errors = ""
		standardOutput = TextStream { outputs.append($0) }
		standardError = TextStream { errors.append($0) }

		MainTool.main(command.split(separator: " ").map(String.init))

		return (outputs, errors)
	}

    func testListImagesOnSpecifiedPages() throws {
		let (output, errors) = try execute("list \(samplePath) -p 2 3 8 100")
		let splitErrors = errors.split(separator: "\n")

		XCTAssertFalse(output.contains("Page 2"))
		XCTAssertTrue(output.contains("Page 3"))
		XCTAssertTrue(output.contains("Page 8"))
		XCTAssert(splitErrors == ["Cannot read page 100"])
    }

	func testListImages() throws {
		let (output, errors) = try execute("list \(samplePath)")

		XCTAssertFalse(output.contains("Page 2:"))
		XCTAssertTrue(output.contains("Page 3:"))
		XCTAssertTrue(output.contains("Page 8"))
		XCTAssertTrue(output.contains("Page 31"))
		XCTAssertTrue(errors.isEmpty)
	}

	func testSaveSpecificImages() throws {
		let (_, error) = try execute(samplePath)
		XCTAssertTrue(error.isEmpty)
	}
}
