//
//  ColorManager.swift
//  SwiftColorGen
//
//  Created by Fernando Del Rio (fernandomdr@gmail.com) on 19/11/17.
//

import Foundation

public struct ColorManager {
    // Get a set of sRGB colors from the storyboard
    public static func getColors(xml: AEXMLElement) -> Set<ColorData> {
        var colors: Set<ColorData> = Set<ColorData>()
        func read(xml: AEXMLElement) {
            if xml.name == "color" {
                ColorSpaceManager.convertToSRGB(xml: xml)
                if let colorSpace = xml.attributes["customColorSpace"],
                   colorSpace == "sRGB",
                   let red = xml.attributes["red"],
                   let green = xml.attributes["green"],
                   let blue = xml.attributes["blue"],
                   let alpha = xml.attributes["alpha"] {
                    let color = ColorData()
                    color.red = Double(red) ?? 0.0
                    color.green = Double(green) ?? 0.0
                    color.blue = Double(blue) ?? 0.0
                    color.alpha = Double(alpha) ?? 0.0
                    colors.insert(color)
                }
            }
            if xml.name != "namedColor" {
                for child in xml.children {
                    read(xml: child)
                }
            }
        }
        read(xml: xml)
        return colors
    }
}
