import Foundation

public struct CLIManager {
    // Returns the arguments in a valid format
    public static func getArgs() -> String {
        let cli = CommandLine()

        // Defining the CLI options

        let baseFolderPath = StringOption(shortFlag: "b",
                                          longFlag: "baseFolder",
                                          required: true,
                                          helpMessage: "Path to the folder where the storyboards are located. Defaults to the current working directory")

        let help = BoolOption(shortFlag: "h",
                              longFlag: "help",
                              helpMessage: """
                                            Usage: swift run ThemeDemo [options]
                                            -b --baseFolder (optional):
                                                Path to the folder where the storyboards are located. Defaults to the current working directory
                                           """)

        cli.addOptions([baseFolderPath, help])

        do {
            try cli.parse()
        } catch {
            print(help.helpMessage)
            exit(1)
        }

        // Print the help, if that's the option selected
        if help.value {
            print(help.helpMessage)
            exit(0)
        }

        // Prevent invalid arguments
        if cli.unparsedArguments.count > 0 {
            print(help.helpMessage)
            exit(1)
        }

        var baseFolder = baseFolderPath.value
        // Avoid running outside of the base folder
        if baseFolder == "/" {
            print("Potentially dangerous. Don't run the tool on the root folder")
            exit(1)
        }

        // Avoiding the need of calculate the final path in this situation
        if (baseFolder ?? "").hasPrefix("..") {
            print("Parent path syntax not supported. Please inform a valid path")
            exit(1)
        }

        // Obtaining the absolute path
        if let folder = baseFolder, folder.hasPrefix(".") {
            baseFolder = PathManager.replaceCurrentPath(folder)
        }

        // Adding default case for the base folder
        if baseFolder == nil {
            baseFolder = FileManager.default.currentDirectoryPath
        }
        // Removing the last slash, if it exists
        if let folder = baseFolder, folder.hasSuffix("/") {
            baseFolder = String(folder.prefix(folder.count-1))
        }

        return PathManager.convertToAbsolutePath(baseFolder ?? "")
    }
}
