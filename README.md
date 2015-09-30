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
> $(CONFIGURATION_BUILD_DIR)/NCursesFramework/

You're now ready to build.

## Using the framework

To start using the framework just add:
```
#import "NCursesFramework.h"
```

It is possible to define all the layouts in xml. You can inflate a xml layout using the NCLayoutInflator:
```
NCGraphic *root = [NCLayoutInflator inflateGraphicFromXML:<NSData>];
```

Here is an example of a xml layout:
```
<NCLinearLayout orientation="horizontal">
	<NCText text="Hello" foreground="red"/>
	<NCText text=" world!"/>
</NCLinearLayout>
```
Although this is a simple example of a layout you can create. You could actually create very complex layouts with multiple children with different containers. You could even split your layouts into several xml files, this is useful when you want to reuse a layout mulitple times in the program.

To render the root graphic:
```
NCRendition *rendition = [root drawInBounds:[[NCCursesPlatform factory] screenSize] withPlatform:[NCCursesPlatform factory]];
[rendition drawToScreen];
```

Although you might not be able to have any time to see it in action because the program might closes itself instantly. To resolve this issue we can wait for user to input a key between each rendering:
```
while(true) {
	// render here...

	NCKey *key = [[NCCursesPlatform factory] getKey];
	if([key isEqualTo:[NCKey NCKEY_q]]) {
		break;
	}
}
```

And here is all of it together:
```
#import <Foundation/Foundation.h>
#import "NCursesFramework.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
		NCGraphic *root = [NCLayoutInflator inflateGraphicFromXML:<NSData>];

		while(true) {
			NCRendition *rendition = [root drawInBounds:[[NCCursesPlatform factory] screenSize] withPlatform:[NCCursesPlatform factory]];
			[rendition drawToScreen];

			NCKey *key = [[NCCursesPlatform factory] getKey];
			if([key isEqualTo:[NCKey NCKEY_q]]) {
				break;
			}
		}
	}
    return 0;
}
```

Have fun!
