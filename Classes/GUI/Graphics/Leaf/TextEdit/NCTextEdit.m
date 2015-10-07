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
        NSString *text = [attributes objectForKey:@"text"];
        NSString *foreground = [attributes objectForKey:@"foreground"];
        NSString *background = [attributes objectForKey:@"background"];
        if(!text) {
            text = @"";
        }
        NCColor *bg = [NCColor colorFromString:background];
        NCColor *fg = [NCColor colorFromString:foreground];
        
        self.text = [[NCMutableString alloc] initWithText:text
                                           withBackground:bg ? bg : [NCColor blackColor]
                                           withForeground:fg ? fg : [NCColor whiteColor]];
        
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
    NSUInteger index = 0;
    NSUInteger cursorIndex = [self indexFromPos:self.cursorPosition];
    
    NSArray *tmp = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *lines = [NSMutableArray array];
    for(NSUInteger i = 0; i < tmp.count; i++) {
        NCString *line = tmp[i];
        NSArray<NCString*> *nlines = [self lineBreakLine:line
                                                inBounds:bounds
                                                withMode:self.lineBreak];
        if(self.cursorPosition.y > i) {
            cursorIndex += nlines.count - 1;
        }
        else if(self.cursorPosition.y == i) {
            int cindex = 0;
            for(NSUInteger j = 0; j < nlines.count; j++) {
                if(cindex + nlines[j].length >= self.cursorPosition.x) {
                    break;
                }
                cindex += nlines[j].length;
                cursorIndex++;
            }
        }
        
        for(NCString *nl in nlines) {
            [lines addObject:[self truncateText:nl
                                       inBounds:bounds
                                       withMode:self.truncation]];
        }
    }
    
    NSUInteger xCursor = 0;
    NSUInteger yCursor = 0;
    
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
            
            NSUInteger rx = x + xOffset;
            NSUInteger ry = y + yOffset;
            
            /* Set cursor draw position to current position. */
            if(!cursorDrawn && index < cursorIndex) {
                xCursor = rx;
                yCursor = ry;
            }
            
            if(cursorIndex == index && self.drawCursor) {
                cursorDrawn = YES;
                [rendition setCharacter:c
                                     at:CGSizeMake(rx, ry)
                         withForeground:[text getBgAtIndex:x]
                         withBackground:[text getFgAtIndex:x]];
            } else {
                [rendition setCharacter:c
                                     at:CGSizeMake(rx, ry)
                         withForeground:[text getFgAtIndex:x]
                         withBackground:[text getBgAtIndex:x]];
            }
            index++;
        }
        /* Set cursor draw position on a new line. */
        if(!cursorDrawn && index < cursorIndex) {
            xCursor = -1;
            yCursor = y + yOffset + 1;
        }
        index++;
    }
    
    /* Draw cursor if not already done so. */
    if(!cursorDrawn && self.drawCursor) {
        xCursor++;
        if(xCursor >= bounds.width) {
            xCursor = 0;
            if(yCursor + 1 < bounds.height) {
                yCursor++;
            }
        }
        [rendition setCharacter:' '
                             at:CGSizeMake(xCursor, yCursor)
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
    for(NSInteger i = 0; i <= pos.y && i < lines.count; i++) {
        NCString *line = [lines objectAtIndex:i];
        if(i < pos.y) {
            index += line.length + 1;
        } else {
            index += MIN(MAX(pos.x, 0), line.length);
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
    CGSize p = [self sizeAfterAdjustmentsForSize:bounds
                                withParentBounds:bounds];
    
    CGSize size = [self sizeOfText:self.text
                         breakMode:self.lineBreak
                             width:p.width];
    
    if(self.cursorPosition.y >= size.height) {
        size.height += self.cursorPosition.y - size.height + 1;
    }
    
    if(self.cursorPosition.x >= size.width) {
        if(self.cursorPosition.x < p.width) {
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

- (void)setCursorPosition:(CGPoint)cursorPosition
{
    _cursorPosition = [self pointFromIndex:[self indexFromPos:cursorPosition]];
}

@end
