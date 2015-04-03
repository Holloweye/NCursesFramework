//
//  NCGraphicText.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCText.h"
#import "NCRendition.h"
#import "NCPlatform.h"

@interface NCText ()
{
    NSArray *_textCache;
    int _widthCache;
}
@end

@implementation NCText

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.lineBreak = NCLineBreakByWordWrapping;
        self.truncation = NCLineTruncationByTruncationTail;
        self.alignment = NCLineAlignmentLeft;
    }
    return self;
}

- (void)setText:(NCString *)text
{
    _text = text;
    _textCache = nil;
    _widthCache = 0;
}

- (void)setLineBreak:(NCLineBreakMode)lineBreak
{
    _lineBreak = lineBreak;
    _textCache = nil;
    _widthCache = 0;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = [super drawInBounds:bounds
                                    withPlatform:platform];
    @try {
        int index = 0;
        NSArray *lines = [self lineBreakAndTruncate:self.text
                                           inBounds:bounds
                                          lineBreak:self.lineBreak
                                          truncMode:self.truncation];
        
        for(int y = 0; lines && y < lines.count; y++) {
            NCString *text = [lines objectAtIndex:y];
            for(NSUInteger x = 0; x < text.length; x++) {
                NCChar *c = [text getCharAtIndex:x];
                
                int xOffset = 0;
                if(self.alignment == NCLineAlignmentRight && text.length < bounds.width) {
                    xOffset = bounds.width - text.length;
                } else if(self.alignment == NCLineAlignmentCenter) {
                    xOffset = (bounds.width - text.length) / 2;
                }
                
                [rendition setCharacter:c.c
                                     at:CGSizeMake(x, y)
                         withForeground:c.foreground
                         withBackground:c.background];
                
                index++;
            }
        }
    }
    @catch (NSException *exception) {
        //[Logger log:[NSString stringWithFormat:@"drawText - Exception thrown: %@/nName:%@/nUserInfo:%@",exception,exception.name,exception.userInfo]];
    }
    return rendition;
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
    if(_textCache && _widthCache == bounds.width) {
        return _textCache;
    } else {
        _widthCache = bounds.width;
        
        NSMutableArray *preWrapping = [NSMutableArray arrayWithArray:[text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]]];
        
        if(mode == NCLineBreakByNoWrapping) {
            return preWrapping;
        }
        
        NSMutableArray *lines = [NSMutableArray array];
        
        for(NCString *t in preWrapping)
        {
            NCString *text = t;
            while(text.length > 0 && lines.count < bounds.height)
            {
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
    return CGSizeMake(MIN(size.width, bounds.width), MIN(size.height, bounds.height));
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
