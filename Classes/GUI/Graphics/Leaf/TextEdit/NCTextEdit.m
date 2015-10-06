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
        self.maxLength = NSIntegerMax;
        self.drawCursor = YES;
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        self.text = [[NCMutableString alloc] init];
        
        NSString *secure = [attributes objectForKey:@"secure"];
        if([secure isEqualToString:@"true"]) {
            self.secure = YES;
        }
        
        NSString *drawCursor = [attributes objectForKey:@"drawCursor"];
        if([drawCursor isEqualToString:@"false"]) {
            self.drawCursor = NO;
        }
        else {
            self.drawCursor = YES;
        }
        
        NSString *maxLen = [attributes objectForKey:@"maxLength"];
        if(maxLen) {
            self.maxLength = [maxLen intValue];
        }
        else {
            self.maxLength = NSIntegerMax;
        }
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
    
    BOOL cursorDrawn = NO;
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
            
            char c = [text getCharAtIndex:x];
            if(self.secure) {
                c = '*';
            }
            
            if(self.cursorPosition.y == y && self.cursorPosition.x == x && self.drawCursor) {
                cursorDrawn = YES;
                [rendition setCharacter:c
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:[text getBgAtIndex:x]
                         withBackground:[text getFgAtIndex:x]];
            } else {
                [rendition setCharacter:c
                                     at:CGSizeMake(x + xOffset, y + yOffset)
                         withForeground:[text getFgAtIndex:x]
                         withBackground:[text getBgAtIndex:x]];
            }
            index++;
        }
    }
    
    if(!cursorDrawn && self.drawCursor) {
        [rendition setCharacter:' '
                             at:CGSizeMake(self.cursorPosition.x, self.cursorPosition.y)
                 withForeground:ColorBlack
                 withBackground:ColorWhite];
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
    NSUInteger len = [self doAddCharacters:chars
                                   atIndex:index];
    
    self.cursorPosition = [self pointFromIndex:index + len];
}

- (void)insertCharacters:(const char *)chars
{
    [self doAddCharacters:chars
                  atIndex:[self indexFromPos:self.cursorPosition]];
}

- (NSUInteger)doAddCharacters:(const char *)chars
                      atIndex:(NSUInteger)index
{
    char *text = (char*)chars;
    BOOL needsRelease = NO;
    if(self.text.length + strlen(chars) > self.maxLength) {
        NSUInteger tot = self.text.length + strlen(chars);
        NSUInteger len = strlen(chars) - (tot - self.maxLength);
        if(len == 0) {
            return 0;
        }
        text = malloc(sizeof(char) * len);
        memcpy(text, chars, len);
        needsRelease = YES;
    }
    
    [self.text insertCharacters:chars
                 withBackground:[NCColor blackColor]
                 withForeground:[NCColor whiteColor]
                        atIndex:index];
    
    if(needsRelease) {
        free(text);
        text = NULL;
    }
    return strlen(text);
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

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize size = [self sizeOfText:self.text
                         breakMode:self.lineBreak
                             width:bounds.width];
    
    if(self.cursorPosition.y >= size.height) {
        size.height += self.cursorPosition.y - size.height + 1;
    }
    
    if(self.cursorPosition.x >= size.width) {
        if(self.cursorPosition.x + 1 < bounds.width) {
            size.width++;
            if(size.height == 0) {
                size.height++;
            }
        }
        else {
            size.height++;
        }
    }
    
    size = CGSizeMake(MIN(size.width, bounds.width), MIN(size.height, bounds.height));
    return [self sizeAfterAdjustmentsForSize:size
                            withParentBounds:bounds];
}

@end
