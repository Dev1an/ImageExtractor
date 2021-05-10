//
//  File.swift
//  
//
//  Created by Damiaan on 10/05/2021.
//

import Foundation

struct TextStream: TextOutputStream {
	let onWrite: (String) -> Void

	func write(_ string: String) {
		onWrite(string)
	}
}

var standardError = TextStream {
	FileHandle.standardOutput.write($0.data(using: .utf8)!)
}
var standardOutput = TextStream {
	FileHandle.standardError.write($0.data(using: .utf8)!)
}
