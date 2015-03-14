//
//  NCScrollBarSimpleStrategy.m
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCScrollBarSimpleStrategy.h"
#import "NCCursesRendition.h"
#import "NCColor.h"

@interface NCScrollBarSimpleStrategy ()
{
    NCColor *_foreground;
    NCColor *_background;
}
@end

@implementation NCScrollBarSimpleStrategy

- (instancetype)init
{
    self = [super init];
    if(self) {
        _foreground = [NCColor whiteColor];
        _background = [NCColor blackColor];
    }
    return self;
}

- (id)initWithForeground:(NCColor *)foreground withBackground:(NCColor *)background
{
    self = [super init];
    if(self) {
        _foreground = foreground;
        _background = background;
    }
    return self;
}

- (NCCursesRendition *)drawInBounds:(CGSize)bounds
                                pos:(int)pos
                                max:(int)max
{
    NCCursesRendition *rendition = [[NCCursesRendition alloc] initWithBounds:bounds];
    
    float const DIFF_FOR_MIN_SIZE = 200;
    float const BAR_MAX_SIZE = MAX(MAX(bounds.width, bounds.height) * 0.7, 1);
    
    float p = 1.0f - MIN((float)max/DIFF_FOR_MIN_SIZE, 1.0f);
    
    if(bounds.width > bounds.height) {
        int barSize = MAX(1, BAR_MAX_SIZE * p);
        int barPos = 0;
        
        if(pos == 0) {
            barPos = 0;
        } else if (pos == max) {
            barPos =  bounds.width - barSize;
        } else {
            barPos = floorf((float)(bounds.width-barSize)/(float)max*(float)pos);
        }
        for(int x = 0; x < barSize; x++) {
            [rendition setCharacter:'#'
                                 at:CGSizeMake(barPos + x, 0)
                     withForeground:_foreground
                     withBackground:_background];
        }
    } else {
        int barSize = MAX(1, BAR_MAX_SIZE * p);
        int barPos = 0;
        
        if(pos == 0) {
            barPos = 0;
        } else if (pos == max) {
            barPos =  bounds.height - barSize;
        } else {
            barPos = floorf((float)(bounds.height-barSize)/(float)max*(float)pos);
        }
        for(int y = 0; y < barSize; y++) {
            [rendition setCharacter:'#'
                                 at:CGSizeMake(0, barPos + y)
                     withForeground:_foreground
                     withBackground:_background];
        }
    }
    return rendition;
}

@end
