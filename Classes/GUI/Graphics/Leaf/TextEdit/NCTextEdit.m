//
//  NCTextEdit.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCTextEdit.h"
#import "NCText_Protected.h"
#import "NCGraphic+Bounds.h"

@implementation NCTextEdit
@dynamic text;

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.text = [[NCMutableString alloc] init];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        self.text = [[NCMutableString alloc] init];
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
    int index = 0;
    NSArray *lines = [self lineBreakAndTruncate:self.text
                                       inBounds:bounds
                                      lineBreak:self.lineBreak
                                      truncMode:self.truncation];
    
    for(int y = 0; lines && y < lines.count; y++) {
        NCString *text = [lines objectAtIndex:y];
        
        int yOffset = 0;
        if(self.verticalAlignment == NCVerticalAlignmentMiddle) {
            yOffset = (bounds.height - lines.count) / 2;
        } else if(self.verticalAlignment == NCVerticalAlignmentBottom) {
            yOffset = (bounds.height - lines.count);
        }
        
        for(NSUInteger x = 0; x < text.length; x++) {
            NCChar *c = [text getCharAtIndex:x];
            
            int xOffset = 0;
            if(self.horizontalAlignment == NCLineAlignmentCenter) {
                xOffset = (bounds.width-text.length) / 2;
            } else if(self.horizontalAlignment == NCLineAlignmentRight) {
                xOffset = (bounds.width-text.length);
            }
            
            if(self.cursorPosition.y == y && self.cursorPosition.x == x) {
                [rendition setCharacter:c.c
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:c.background.color
                         withBackground:c.foreground.color];
            } else {
                [rendition setCharacter:c.c
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:c.foreground.color
                         withBackground:c.background.color];
            }
            index++;
        }
    }
    
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (void)addCharacter:(char)c
                  at:(CGPoint)pos
{
    [self.text insertCharacter:c
                withBackground:[NCColor blackColor]
                withForeground:[NCColor whiteColor]
                       atIndex:[self indexFromPos:pos]];
}

- (void)deleteCharacterAt:(CGPoint)pos
{
    [self.text deleteCharacterAtIndex:[self indexFromPos:pos]];
}

- (NSUInteger)indexFromPos:(CGPoint)pos
{
    NSUInteger index = 0;
    NSArray *lines = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for(NSUInteger i = 0; i < (NSUInteger)pos.y + 1; i++) {
        NCString *line = [lines objectAtIndex:i];
        if(i < pos.y) {
            index += line.length;
        } else {
            index += (pos.x < line.length ? MAX(line.length - 1, 0) : 0);
        }
    }
    return index;
}

@end
