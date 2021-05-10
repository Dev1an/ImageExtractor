//
//  File.swift
//  
//
//  Created by Damiaan on 10/05/2021.
//

import Foundation
import ArgumentParser
import ImageExtractor

let pageOptionHelp: ArgumentHelp = "A 0-based index of the pages you want to extract images from"

extension MainTool {
	struct List: ParsableCommand {
		@Argument(help: "The file URL for the PDF input", transform: URL.init(fileURLWithPath:))
		var input: URL

		@Option(name: [.short, .long], parsing: .upToNextOption, help: pageOptionHelp)
		var pages = [Int]()

		func run() throws {
			let pdf = try pdfDocument(from: input)

			let pageIndices = pages.isEmpty ? AnySequence(0 ..< pdf.pageCount) : AnySequence(pages)
			for index in pageIndices {
				if let page = pdf.page(at: index) {
					try extractImages(from: page) { (image, name) in
						print("Page \(index):", name, image, to: &standardOutput)
					}
				} else {
					print("Cannot read page \(index)", to: &standardError)
				}
			}
		}
	}
}
