//
//  File.swift
//  
//
//  Created by Damiaan on 10/05/2021.
//

import PDFKit

public func extractImages(from url: URL, consumer: @escaping (EmbeddedImage, Int, String)->Void) throws {
	let document = try pdfDocument(from: url)
	try extractImages(from: document, consumer: consumer)
}

public func extractImages(from data: Data, consumer: @escaping (EmbeddedImage, Int, String)->Void) throws {
	let document = try pdfDocument(from: data)
	try extractImages(from: document, consumer: consumer)
}

public func pdfDocument(from url: URL) throws -> PDFDocument {
	guard let document = PDFDocument(url: url) else {
		throw PDFReadError.cannotInterpretFileAsPDFDocumentRepresentation
	}
	return document
}

public func pdfDocument(from data: Data) throws -> PDFDocument {
	guard let document = PDFDocument(data: data) else {
		throw PDFReadError.cannotInterpretFileAsPDFDocumentRepresentation
	}
	return document
}

public func extractImages(from pdf: PDFDocument, consumer consume: @escaping (EmbeddedImage, Int, String)->Void) throws {
	for pageNumber in 0..<pdf.pageCount {
		guard let page = pdf.page(at: pageNumber) else {
			throw PDFReadError.couldNotOpenPage(pageNumber)
		}
		try extractImages(from: page) { consume($0, pageNumber, $1) }
	}
}
