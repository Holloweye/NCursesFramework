//
//  NCBorderFilledStrategy.m
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCBorderFilledStrategy.h"
#import "NCColor.h"
#import "NCRendition.h"
#import "NCPlatform.h"

@interface NCBorderFilledStrategy ()
{
    char _nw;
    char _ne;
    char _sw;
    char _se;
    char _n;
    char _e;
    char _s;
    char _w;
    NCColor *_foreground;
    NCColor *_background;
}
@end

@implementation NCBorderFilledStrategy

- (instancetype)init
{
    self = [super init];
    if(self) {
        _nw = '+';
        _ne = '+';
        _sw = '+';
        _se = '+';
        _w = '|';
        _n = '-';
        _e = '|';
        _s = '-';
        _foreground = [NCColor whiteColor];
        _background = [NCColor blackColor];
    }
    return self;
}

- (id)initWithCornerNW:(char)nw
          withCornerNE:(char)ne
          withCornerSW:(char)sw
          withCornerSE:(char)se
                 withN:(char)n
                 withE:(char)e
                 withS:(char)s
                 withW:(char)w
        withBackground:(NCColor *)background
        withForeground:(NCColor *)foreground
{
    self = [super init];
    if(self) {
        _nw = nw;
        _ne = ne;
        _sw = sw;
        _se = se;
        _w = w;
        _n = n;
        _e = e;
        _s = s;
        _background = background;
        _foreground = foreground;
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
                     position:(NCBorderPosition)position
{
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    for(int y = 0; y < bounds.height; y++) {
        for(int x = 0; x < bounds.width; x++) {
            if(position == NCBorderPositionTop)
            {
                [rendition setCharacter:(x == 0 ? _nw : (x == bounds.width-1 ? _ne : _n))
                                     at:CGSizeMake(x, y)
                         withForeground:_foreground
                         withBackground:_background];
            }
            else if(position == NCBorderPositionLeft)
            {
                [rendition setCharacter:(y == 0 ? _nw : (y == bounds.width-1 ? _sw : _w))
                                     at:CGSizeMake(x, y)
                         withForeground:_foreground
                         withBackground:_background];
            }
            else if(position == NCBorderPositionBottom)
            {
                [rendition setCharacter:(x == 0 ? _sw : (x == bounds.width-1 ? _se : _s))
                                     at:CGSizeMake(x, y)
                         withForeground:_foreground
                         withBackground:_background];
            }
            else
            {
                [rendition setCharacter:(y == 0 ? _ne : (y == bounds.width-1 ? _se : _e))
                                     at:CGSizeMake(x, y)
                         withForeground:_foreground
                         withBackground:_background];
            }
        }
    }
    return rendition;
}

@end
