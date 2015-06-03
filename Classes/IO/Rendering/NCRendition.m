//
//  NCRendition.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCRendition.h"

@implementation NCRendition

- (id)initWithBounds:(CGSize)bounds
{
    self = [super init];
    if(self) {
    }
    return self;
}

- (CGSize)bounds
{
    return CGSizeZero;
}

- (void)setCharacter:(char)c
                  at:(CGSize)pos
      withForeground:(Color)foreground
      withBackground:(Color)background
{
}

- (void)mergeRendition:(NCRendition *)rendition
               inFrame:(CGRect)frame
{
}

- (void)drawToScreen
{
}

+ (CGSize)screenSize
{
    return CGSizeMake(0, 0);
}

@end
