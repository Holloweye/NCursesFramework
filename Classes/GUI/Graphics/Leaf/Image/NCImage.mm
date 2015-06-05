//
//  NCImage.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 04/06/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCImage.h"
#import "NCGraphic+Bounds.h"
#import "BKAsciiConverter.h"
#import "BKAsciiDefinition.h"

@implementation NCImage

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.background = [NCColor blackColor];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        self.background = [NCColor colorFromString:[attributes objectForKey:@"background"]];
        self.background = (self.background ? self.background : [NCColor blackColor]);
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    CGRect padding = [self padding];
    bounds = CGSizeMake(MAX(bounds.width - padding.origin.x - padding.size.width, 0),
                        MAX(bounds.height - padding.origin.y - padding.size.height, 0));
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    
    BKAsciiConverter *convert = [[BKAsciiConverter alloc] initWithDefinition:[[BKAsciiDefinition alloc] init]];
    convert.columns = bounds.width;
    NSImage *image = [[NSImage alloc] initWithData:[NSData dataWithContentsOfFile:@"/Users/christer/Desktop/test.png"]];
    [convert convertToCharsAndColors:image
                          withColors:@[[NSNumber numberWithUnsignedLong:ColorBlack],
                                       [NSNumber numberWithUnsignedLong:ColorRed],
                                       [NSNumber numberWithUnsignedLong:ColorGreen],
                                       [NSNumber numberWithUnsignedLong:ColorYellow],
                                       [NSNumber numberWithUnsignedLong:ColorBlue],
                                       [NSNumber numberWithUnsignedLong:ColorMagenta],
                                       [NSNumber numberWithUnsignedLong:ColorCyan],
                                       [NSNumber numberWithUnsignedLong:ColorWhite]]
                    withActualColors:@[[NSColor colorWithRed:0 green:0 blue:0 alpha:1],
                                       [NSColor redColor],
                                       [NSColor greenColor],
                                       [NSColor yellowColor],
                                       [NSColor blueColor],
                                       [NSColor magentaColor],
                                       [NSColor cyanColor],
                                       [NSColor colorWithRed:1 green:1 blue:1 alpha:1]]
                            withMode:ImageScaleScaleToFill
                           withWidth:bounds.width
                          withHeight:bounds.height
                        onCompletion:^(int *matrix, int width, int height) {
                            
                            for(int x = 0; x < MIN(width, rendition.bounds.width); x++) {
                                for(int y = 0; y < MIN(height, rendition.bounds.height); y++) {
                                    
                                    const int i = x * height + y;
                                    const int v = *(matrix + i);
                                    
                                    Color bg, fg;
                                    char c;
                                    if(v > 0) {
                                        bg = (Color)(v / 10000);
                                        fg = (Color)(v % 10000 / 1000);
                                        c = v % 1000;
                                    } else {
                                        bg = ColorBlack;
                                        fg = ColorWhite;
                                        c = ' ';
                                    }
                                    
                                    [rendition setCharacter:c
                                                         at:CGSizeMake(x, y)
                                             withForeground:fg
                                             withBackground:bg];
                                }
                            }
                        }];
    
    
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    return [self sizeAfterAdjustmentsForSize:bounds
                            withParentBounds:bounds];
}

@end
