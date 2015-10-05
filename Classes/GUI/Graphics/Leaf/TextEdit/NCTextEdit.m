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
#import "Logger.h"

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
            int xOffset = 0;
            if(self.horizontalAlignment == NCLineAlignmentCenter) {
                xOffset = (bounds.width-text.length) / 2;
            } else if(self.horizontalAlignment == NCLineAlignmentRight) {
                xOffset = (bounds.width-text.length);
            }
            
            if(self.cursorPosition.y == y && self.cursorPosition.x == x) {
                [rendition setCharacter:[text getCharAtIndex:x]
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:[text getBgAtIndex:x]
                         withBackground:[text getFgAtIndex:x]];
            } else {
                [rendition setCharacter:[text getCharAtIndex:x]
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:[text getFgAtIndex:x]
                         withBackground:[text getBgAtIndex:x]];
            }
            index++;
        }
    }
    
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (void)addCharacter:(char)c
{
    char *cp = malloc(sizeof(char) * 2);
    cp[0] = c;
    cp[1] = '\0';
    [self addCharacters:cp];
    free(cp);
}

- (void)addCharacters:(const char *)chars
{
    NSUInteger index = [self indexFromPos:self.cursorPosition];
    [self.text insertCharacters:chars
                 withBackground:[NCColor blackColor]
                 withForeground:[NCColor whiteColor]
                        atIndex:index];
    self.cursorPosition = [self pointFromIndex:index + strlen(chars)];
}

- (void)insertCharacters:(const char *)chars
{
    [self.text insertCharacters:chars
                 withBackground:[NCColor blackColor]
                 withForeground:[NCColor whiteColor]
                        atIndex:[self indexFromPos:self.cursorPosition]];
}

- (void)removeCharacters:(int)count
{
    NSUInteger index = [self indexFromPos:self.cursorPosition];
    if(index >= count) {
        index -= count;
    }
    else {
        index = 0;
    }
    
    if([self.text deleteCharacterAtIndex:index
                                   count:count]) {
        self.cursorPosition = [self pointFromIndex:index];
    }
}

- (void)deleteCharacters:(int)count
{
    [self.text deleteCharacterAtIndex:[self indexFromPos:self.cursorPosition]
                                count:count];
}

- (NSUInteger)indexFromPos:(CGPoint)pos
{
    NSUInteger index = 0;
    NSArray *lines = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for(NSUInteger i = 0; i <= (NSUInteger)pos.y; i++) {
        NCString *line = [lines objectAtIndex:i];
        if(i < pos.y) {
            index += line.length + 1;
        } else {
            index += MIN(pos.x, line.length);
        }
    }
    return index;
}

- (CGPoint)pointFromIndex:(NSUInteger)index
{
    CGPoint point = CGPointZero;
    for(NSUInteger i = 0; i < index; i++) {
        if([[NSCharacterSet newlineCharacterSet] characterIsMember:[self.text getCharAtIndex:i]]) {
            point.y++;
            point.x = 0;
        } else {
            point.x++;
        }
    }
    return point;
}

@end
