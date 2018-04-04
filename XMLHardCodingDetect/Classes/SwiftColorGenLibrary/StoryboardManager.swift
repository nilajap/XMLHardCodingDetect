//
//  StoryboardManager.swift
//  SwiftColorGen
//
//  Created by Fernando Del Rio (fernandomdr@gmail.com) on 19/11/17.
//

import Foundation


public struct StoryboardManager {
    // Iterate over the base folder to get the storyboard files
    public static func getStoryboards(baseFolder: String) -> [String] {
        var storyboards: [String] = []
        let enumerator = FileManager.default.enumerator(atPath: baseFolder)
        while let path = enumerator?.nextObject() as? String {
            if PathManager.isValidStoryboard(path: path) {
                storyboards.append("\(baseFolder)/\(path)")
            }
        }
        return storyboards
    }

    // Reads the storyboard and returns a XML document
    public static func readStoryboard(path: String) -> AEXMLDocument {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return AEXMLDocument()
        }
        guard let xml = try? AEXMLDocument(xml: data, options: AEXMLOptions()) else {
            return AEXMLDocument()
        }
        return xml
    }

    // Read the storyboard returning the colors found
    public static func readStoryboardColors(path: String) -> Set<ColorData> {
        let xml = readStoryboard(path: path)
        var colorDataArray = ColorManager.getColors(xml: xml.root)
        colorDataArray = Set(colorDataArray.map { (colordata) -> ColorData in
            colordata.path = path
            return colordata
        })
        return colorDataArray
    }
}
