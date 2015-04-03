//
//  NCBorderDecorator.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCBorderDecorator.h"
#import "NCRendition.h"
#import "NCBorderStrategy.h"
#import "NCBorderFilledStrategy.h"
#import "NCRender.h"
#import "NCPlatform.h"

@implementation NCBorderDecorator

- (instancetype)init
{
    self = [super init];
    if(self) {
        _strategy = [[NCBorderFilledStrategy alloc] init];
    }
    return self;
}

- (id)initWithGraphic:(NCGraphic *)graphic
{
    self = [super initWithGraphic:graphic];
    if(self) {
        _strategy = [[NCBorderFilledStrategy alloc] init];
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    
    if(self.graphic && bounds.width > 2 && bounds.height > 2) {
        NCRendition *graphicRendition = [self.graphic drawInBounds:CGSizeMake(bounds.width-2, bounds.height-2)
                                                      withPlatform:platform];
        [rendition mergeRendition:graphicRendition
                          inFrame:CGRectMake(1, 1, bounds.width-2, bounds.width-2)];
    }
    
    if(self.strategy) {
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(bounds.width, MIN(1, bounds.height))
                                                 withPlatform:platform
                                                     position:NCBorderPositionTop]
                          inFrame:CGRectMake(0, 0, bounds.width, MIN(bounds.height, 1))];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(MIN(1, bounds.width), bounds.height)
                                                 withPlatform:platform
                                                     position:NCBorderPositionLeft]
                          inFrame:CGRectMake(0, 0, MIN(bounds.width, 1), bounds.height)];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(bounds.width, MIN(1, bounds.height))
                                                 withPlatform:platform
                                                     position:NCBorderPositionBottom]
                          inFrame:CGRectMake(0, bounds.height-1, bounds.width, MIN(bounds.height, 1))];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(MIN(1, bounds.width), bounds.height)
                                                 withPlatform:platform
                                                     position:NCBorderPositionRight]
                          inFrame:CGRectMake(bounds.width-1, 0, MIN(bounds.width, 1), bounds.height)];
    }
    
    return rendition;
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize size = CGSizeZero;
    if(self.graphic) {
        size = [self.graphic sizeWithinBounds:bounds];
        size = CGSizeMake(size.width+2, size.height+2);
    }
    return CGSizeMake(MIN(bounds.width, size.width), MIN(bounds.height, size.height));
}

@end
