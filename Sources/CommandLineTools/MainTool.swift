//
//  File.swift
//  
//
//  Created by Damiaan on 10/05/2021.
//

import ArgumentParser

public struct MainTool: ParsableCommand {
	public init() {}

	public static let configuration = CommandConfiguration(
		commandName: "ImageExtractor",
		abstract: "A utility to extract original images from PDFs",
		discussion: "ImageExtracor gives you acces to the original image representations of bitmap assets in PDFs. It does not rerender, resample, or scale the images, but provides you the actual representations of the images, just as they are encoded in the PDF",
		subcommands: [List.self, Save.self],
		defaultSubcommand: Save.self
	)
}
