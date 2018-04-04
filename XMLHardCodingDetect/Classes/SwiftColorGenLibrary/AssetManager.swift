//
//  AssetManager.swift
//  SwiftColorGen
//
//  Created by Fernando del Rio (fernandomdr@gmail.com) on 24/11/17.
//

import Foundation

open class AssetManager {

    // Iterate over the base folder to get the storyboard files
    private static func getAssets(assetsFolder: String) -> [String] {
        var assets: [String] = []
        let enumerator = FileManager.default.enumerator(atPath: assetsFolder)
        while let path = enumerator?.nextObject() as? String {
            if PathManager.isValidColorset(path: path) {
                assets.append("\(assetsFolder)/\(path)")
            }
        }
        return assets
    }
}
