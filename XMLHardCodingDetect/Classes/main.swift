
import Foundation

print("Hello, World!")

func main() {
    let baseFolderPath = CLIManager.getArgs()
    let newColors = getColors(baseFolderPath)
    print(newColors.count)
    let _ = newColors.map { (colorData) -> Void in
        print(colorData.path)
    }
    if newColors.count > 0 {
        exit(0)
    }
//    print(getFonts(args: args))
}

func getColors(_ baseFolder: String) -> Set<ColorData> {
    // Gets the list of storyboards
    let storyboards = StoryboardManager.getStoryboards(baseFolder: baseFolder)
    var allColors: Set<ColorData> = Set<ColorData>()
    storyboards.forEach { storyboard in
        // Gets the list of colors
        let colors = StoryboardManager.readStoryboardColors(path: storyboard)
        // Place all colors in a set to avoid duplicates
        allColors = allColors.union(colors)
    }
    return allColors
}

//func getFonts(args: (baseFolder: String, assetsFolder: String, outputFile: String)) -> Set<ColorData> {
//    // Gets the list of storyboards
//    let storyboards = StoryboardManager.getStoryboards(baseFolder: args.baseFolder)
//    let allColors: Set<ColorData> = Set<ColorData>()
//    storyboards.forEach { storyboard in
//        print("In progress")
//    }
//    return allColors
//}

main()
