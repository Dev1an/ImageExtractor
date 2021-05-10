//
//  File.swift
//  
//
//  Created by Damiaan on 10/05/2021.
//

import ArgumentParser
import Foundation
import ImageExtractor
import class Cocoa.NSImage

extension MainTool {
	struct Save: ParsableCommand {
		@Argument(help: "The file URL for the PDF input", transform: URL.init(fileURLWithPath:))
		var input: URL

		@Option(name: [.short, .long], parsing: .upToNextOption)
		var pages = [Int]()

		func run() throws {
			let pdf = try pdfDocument(from: input)
			let pageIndices = pages.isEmpty ? AnySequence(0 ..< pdf.pageCount) : AnySequence(pages)

			let directory = directoryURL()
			try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false)
			for index in pageIndices {
				if let page = pdf.page(at: index) {
					try extractImages(from: page) { (image, name) in
						let filePath = directory.appendingPathComponent("page \(index) \(name)")
						do {
							switch image {
							case .jpg(let data): try data.write(to: filePath.appendingPathExtension("jpg"))
							case .raw(let image):
								let data = NSImage(cgImage: image, size: NSSize(width: image.width, height: image.height)).tiffRepresentation!
								try data.write(to: filePath.appendingPathExtension("tiff"))
							}
						} catch {
							print(error, to: &standardError)
						}
					}
				} else {
					print("Cannot read page \(index)", to: &standardError)
				}
			}
			print("Files saved to \(directory.path)", to: &standardOutput)
		}

		func directoryURL() -> URL {
			let url = input.deletingPathExtension()
			var number = 1
			while FileManager.default.fileExists(atPath: url.path + "\(number)") {
				number += 1
			}
			return URL(string: url.absoluteString + "\(number)")!
		}
	}
}
