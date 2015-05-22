//
//  NCDecorator.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDecorator.h"
#import "NCGraphic+Bounds.h"

@implementation NCDecorator

- (id)initWithGraphic:(NCGraphic *)graphic
{
    self = [super init];
    if(self) {
        [self addChild:graphic];
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    return [_graphic drawInBounds:bounds
                     withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize size = CGSizeZero;
    if(self.graphic) {
        size = [self.graphic sizeWithinBounds:bounds];
        size = CGSizeMake(size.width, size.height);
    }
    size = CGSizeMake(MIN(bounds.width, size.width), MIN(bounds.height, size.height));
    return [self sizeRespectingMinMaxValuesForBounds:size
                                     forParentBounds:bounds];
}

- (void)addChild:(NCGraphic *)child
{
    _graphic = child;
}

- (void)removeChild:(NCGraphic *)child
{
    _graphic = nil;
}

- (NCGraphic *)findGraphicWithId:(NSString *)sid
{
    NCGraphic *graphic = nil;
    if([self.sid isEqualToString:sid]) {
        graphic = self;
    }
    if(!graphic) {
        graphic = [_graphic findGraphicWithId:sid];
    }
    return graphic;
}

@end
