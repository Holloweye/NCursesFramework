//
//  NCRendition.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCRendition.h"
#import "NCRendition_Protected.h"
#import "NCRender.h"
#import "NCMatrix.h"

@implementation NCRendition

- (id)initWithBounds:(CGSize)bounds
{
    self = [super init];
    if(self) {
        _matrix = [[NCMatrix alloc] initWithSize:bounds];
    }
    return self;
}

- (CGSize)bounds
{
    return _matrix.size;
}

- (void)setCharacter:(char)c
                  at:(CGSize)pos
      withForeground:(NCColor *)foreground
      withBackground:(NCColor *)background
{
    [_matrix setObject:[[NCRender alloc] initWithCharacter:c
                                            withBackground:background
                                            withForeground:foreground]
                 atPos:pos];
}

- (NCRender *)atIndex:(CGSize)pos
{
    NCRender *render = [_matrix objectAtPos:pos];
    return [render isKindOfClass:[NSNull class]] ? nil : render;
}

- (void)mergeRendition:(NCRendition *)rendition
               inFrame:(CGRect)frame
{
    if(rendition) {
        for(int y = 0; y < MIN(frame.size.height, rendition.bounds.height); y++)
        {
            for(int x = 0; x < MIN(frame.size.width, rendition.bounds.width); x++)
            {
                NCRender *render = [rendition atIndex:CGSizeMake(x, y)];
                if([render isKindOfClass:[NCRender class]]) {
                    [self setCharacter:render.character
                                    at:CGSizeMake(x+frame.origin.x, y+frame.origin.y)
                        withForeground:render.foreground
                        withBackground:render.background];
                }
            }
        }
    }
}

- (void)drawToScreen
{
    
}

+ (CGSize)screenSize
{
    return CGSizeMake(0, 0);
}

@end
