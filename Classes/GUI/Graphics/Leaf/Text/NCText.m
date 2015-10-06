//
//  NCText.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCText.h"
#import "NCText_Protected.h"
#import "NCRendition.h"
#import "NCPlatform.h"
#import "NCGraphic+Bounds.h"

@interface NCText ()
{
    NSArray *_textCache;
    int _widthCache;
    int _heightCache;
}
@end

@implementation NCText

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.verticalAlignment = NCVerticalAlignmentTop;
        self.horizontalAlignment = NCLineAlignmentLeft;
        self.lineBreak = NCLineBreakByWordWrapping;
        self.truncation = NCLineTruncationByTruncationTail;
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        if([[attributes objectForKey:@"lineBreak"] isEqualToString:@"noWrapping"]) {
            self.lineBreak = NCLineBreakByNoWrapping;
        } else if([[attributes objectForKey:@"lineBreak"] isEqualToString:@"charWrapping"]) {
            self.lineBreak = NCLineBreakByCharWrapping;
        } else {
            self.lineBreak = NCLineBreakByWordWrapping;
        }
        
        if([[attributes objectForKey:@"truncation"] isEqualToString:@"clipping"]) {
            self.truncation = NCLineTruncationByClipping;
        } else if([[attributes objectForKey:@"truncation"] isEqualToString:@"truncatingHead"]) {
            self.truncation = NCLineTruncationByTruncatingHead;
        } else {
            self.truncation = NCLineTruncationByTruncationTail;
        }
        
        if([[attributes objectForKey:@"horizontalAlignment"] isEqualToString:@"center"]) {
            self.horizontalAlignment = NCLineAlignmentCenter;
        } else if([[attributes objectForKey:@"horizontalAlignment"] isEqualToString:@"right"]) {
            self.horizontalAlignment = NCLineAlignmentRight;
        } else {
            self.horizontalAlignment = NCLineAlignmentLeft;
        }
        
        if([[attributes objectForKey:@"verticalAlignment"] isEqualToString:@"middle"]) {
            self.verticalAlignment = NCVerticalAlignmentMiddle;
        } else if([[attributes objectForKey:@"verticalAlignment"] isEqualToString:@"bottom"]) {
            self.verticalAlignment = NCVerticalAlignmentBottom;
        } else {
            self.verticalAlignment = NCVerticalAlignmentTop;
        }
        
        NSString *text = [attributes objectForKey:@"text"];
        NSString *foreground = [attributes objectForKey:@"foreground"];
        NSString *background = [attributes objectForKey:@"background"];
        if(!text) {
            text = @"";
        }
        NCColor *bg = [NCColor colorFromString:background];
        NCColor *fg = [NCColor colorFromString:foreground];
        self.text = [[NCString alloc] initWithText:text
                                    withBackground:bg ? bg : [NCColor blackColor]
                                    withForeground:fg ? fg : [NCColor whiteColor]];
    }
    return self;
}

- (void)setText:(NCString *)text
{
    _text = text;
    _textCache = nil;
    _widthCache = 0;
    _heightCache = 0;
}

- (void)setLineBreak:(NCLineBreakMode)lineBreak
{
    _lineBreak = lineBreak;
    _textCache = nil;
    _widthCache = 0;
    _heightCache = 0;
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
            
            [rendition setCharacter:[text getCharAtIndex:x]
                                 at:CGSizeMake(x + xOffset, y + yOffset)
                     withForeground:[text getFgAtIndex:x]
                     withBackground:[text getBgAtIndex:x]];
            
            index++;
        }
    }
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (NSArray*) lineBreakAndTruncate:(NCString*)text
                         inBounds:(CGSize)bounds
                        lineBreak:(NCLineBreakMode)lineMode
                        truncMode:(NCLineTruncationMode)trucMode
{
    NSMutableArray *lines = [NSMutableArray arrayWithArray:[self lineBreakText:text
                                                                      inBounds:bounds
                                                                      withMode:lineMode]];
    for(int i = 0; i < lines.count; i++) {
        NCString *line = [lines objectAtIndex:i];
        [lines replaceObjectAtIndex:i withObject:[self truncateText:line
                                                           inBounds:bounds
                                                           withMode:trucMode]];
    }
    return lines;
}

- (NCString*) truncateText:(NCString*)text
                  inBounds:(CGSize)bounds
                  withMode:(NCLineTruncationMode)mode
{
    if(text && text.length > bounds.width) {
        if(mode == NCLineTruncationByClipping)
        {
            text = [text substringToIndex:bounds.width];
        }
        else if(mode == NCLineTruncationByTruncatingHead)
        {
            text = [[text substringFromIndex:text.length - bounds.width + 3] appendHeadText:[[NCString alloc] initWithText:@"..."
                                                                                                            withBackground:[NCColor blackColor]
                                                                                                            withForeground:[NCColor whiteColor]]];
            text = [text substringToIndex:bounds.width];
        }
        else if(mode == NCLineTruncationByTruncationTail)
        {
            text = [[text substringToIndex:bounds.width-3] appendTailText:[[NCString alloc] initWithText:@"..."
                                                                                          withBackground:[NCColor blackColor]
                                                                                          withForeground:[NCColor whiteColor]]];
        }
    }
    return text;
}

- (NSArray*) lineBreakText:(NCString*)text
                  inBounds:(CGSize)bounds
                  withMode:(NCLineBreakMode)mode
{
    if(_textCache && _widthCache == bounds.width && _heightCache == bounds.height) {
        return _textCache;
    } else {
        _widthCache = bounds.width;
        _heightCache = bounds.height;
        
        NSMutableArray *preWrapping = [NSMutableArray arrayWithArray:[text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
        
        if(mode == NCLineBreakByNoWrapping) {
            return preWrapping;
        }
        
        NSMutableArray *lines = [NSMutableArray array];
        
        for(NCString *t in preWrapping)
        {
            NCString *text = t;
            
            NSInteger maxPossibleLength = MIN(text.length, bounds.width);
            
            if(mode == NCLineBreakByCharWrapping)
            {
                [lines addObject:[text substringToIndex:maxPossibleLength]];
                text = [text substringFromIndex:maxPossibleLength];
            }
            else if(mode == NCLineBreakByWordWrapping)
            {
                if(maxPossibleLength == text.length) {
                    [lines addObject:text];
                    text = [[NCString alloc] initWithText:@""
                                           withBackground:[NCColor blackColor]
                                           withForeground:[NCColor whiteColor]];
                } else {
                    if(!isblank([text characterAtIndex:maxPossibleLength-1]) && !isblank([text characterAtIndex:maxPossibleLength])) {
                        NSInteger wordS = maxPossibleLength-1;
                        NSInteger wordL = 0;
                        for(NSInteger i = maxPossibleLength-1; i >= 0; i--) {
                            char c = [text characterAtIndex:i];
                            if(isblank(c)) {
                                break;
                            } else {
                                wordS = i;
                            }
                        }
                        for(NSInteger i = wordS; i < text.length; i++) {
                            char c = [text characterAtIndex:i];
                            wordL++;
                            if(isblank(c)) {
                                break;
                            }
                        }
                        if(wordL > bounds.width) {
                            [lines addObject:[text substringToIndex:maxPossibleLength]];
                            text = [text substringFromIndex:maxPossibleLength];
                        } else {
                            [lines addObject:[text substringToIndex:wordS]];
                            text = [text substringFromIndex:wordS];
                        }
                        
                    } else {
                        [lines addObject:[text substringToIndex:maxPossibleLength]];
                        text = [text substringFromIndex:maxPossibleLength];
                    }
                }
            }
        }
        
        _textCache = lines;
        return lines;
    }
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize size = [self sizeOfText:self.text
                         breakMode:self.lineBreak
                             width:bounds.width];
    
    size = CGSizeMake(MIN(size.width, bounds.width), MIN(size.height, bounds.height));
    return [self sizeAfterAdjustmentsForSize:size
                            withParentBounds:bounds];
}

- (CGSize) sizeOfText:(NCString*)text
            breakMode:(NCLineBreakMode)linebreak
                width:(NSUInteger)width
{
    NSArray *lines = [self lineBreakText:text
                                inBounds:CGSizeMake(width, NSIntegerMax)
                                withMode:linebreak];
    NSUInteger w = 0;
    for(NSString *line in lines) {
        if(w < line.length) {
            w = line.length;
        }
    }
    return CGSizeMake(w, lines.count);
}

@end
