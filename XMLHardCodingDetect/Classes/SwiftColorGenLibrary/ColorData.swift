
import Foundation

// The color data structure, unically identified by
// the RGBA values. The assetName and the outputName
// are used to name the colors inside the .xcassets
// folder and the generated swift file functions
open class ColorData: Hashable {
    open var red: Double
    open var green: Double
    open var blue: Double
    open var alpha: Double
    open var path: String

    open var name: String {
        let redValue = Int(round(255*red))
        let greenValue = Int(round(255*green))
        let blueValue = Int(round(255*blue))
        let alphaValue = Int(round(255*alpha))
        let hexRed = String(format: "%2X", redValue)
            .replacingOccurrences(of: " ", with: "0")
        let hexGreen = String(format: "%2X", greenValue)
            .replacingOccurrences(of: " ", with: "0")
        let hexBlue = String(format: "%2X", blueValue)
            .replacingOccurrences(of: " ", with: "0")
        return "\(hexRed)\(hexGreen)\(hexBlue) (alpha \(alphaValue))"
    }

    open var assetName: String {
        let alphaValue = Int(round(255*alpha))
        if alpha == 1.0 {
            return name.replacingOccurrences(of: " (\(alphaValue) )", with: "")
        } else {
            return name
        }
    }

    open var outputName: String {
        let alphaValue = Int(round(255*alpha))
        if alpha == 1.0 {
            return name.replacingOccurrences(of: " (alpha \(alphaValue))", with: "")
        } else {
            return name.replacingOccurrences(of: " (alpha \(alphaValue))", with: "Alpha\(alphaValue)")
        }
    }

    public init() {
        red = 0.0
        green = 0.0
        blue = 0.0
        alpha = 0.0
        path = ""
    }

    open static func ==(lhs: ColorData, rhs: ColorData) -> Bool {
        return fabs(lhs.red-rhs.red) < 1e-4 &&
               fabs(lhs.green-rhs.green) < 1e-4 &&
               fabs(lhs.blue-rhs.blue) < 1e-4 &&
               fabs(lhs.alpha-rhs.alpha) < 1e-4
    }

    open var hashValue: Int {
        return (red+blue+green+alpha).hashValue
    }
}
