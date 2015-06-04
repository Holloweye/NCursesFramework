# Curses Framework - Objective-C

## Setting up project

### Starting from scratch

If you already have a project which you want to integrate with Curses Framework then you should continue to "Using the correct build settings". 
If you are starting a new project from scratch with Curses Framework then continue here.

The first thing you need to do is create a new OSX - Application - Command Line Tool. Make sure the language is set to Objective-C.

### Using the correct build settings

#### Link Curses Framework.
1. Right click on any item or folder in the project navigator and select 'Add Files to "<your project>"'. 
2. Navigate and select NCursesFramework.xcodeproj.
3. Go to Build Phases -> Target Dependencies. And add NCursesFramework that you recently added.
4. Link Binary With Libraries, add libNCursesFramework.dylib.

#### Build settings
Add the following Other Linker Flags:
> -lncurses
> -lc++

Add to Header Search Paths:
> $(CONFIGURATION_BUILD_DIR)

You're now ready to build.

