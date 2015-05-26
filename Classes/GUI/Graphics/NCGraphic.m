//
//  NCGraphic.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCPlatform.h"
#import "NCRendition.h"
#import "NCGraphic+Bounds.h"
#import "NCEvaluate.h"

@implementation NCGraphic

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.gravity = NCGravityTopLeft;
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if(self) {
        NSString *gravityStr = [attributes objectForKey:@"gravity"];
        
        NSNumber *gravity = [@{@"topLeft":[NSNumber numberWithInt:NCGravityTopLeft],
                               @"topCenter":[NSNumber numberWithInt:NCGravityTopCenter],
                               @"topRight":[NSNumber numberWithInt:NCGravityTopRight],
                               
                               @"middleLeft":[NSNumber numberWithInt:NCGravityMiddleLeft],
                               @"middleCenter":[NSNumber numberWithInt:NCGravityMiddleCenter],
                               @"middleRight":[NSNumber numberWithInt:NCGravityMiddleRight],
                               
                               @"bottomLeft":[NSNumber numberWithInt:NCGravityBottomLeft],
                               @"bottomCenter":[NSNumber numberWithInt:NCGravityBottomCenter],
                               @"bottomRight":[NSNumber numberWithInt:NCGravityBottomRight]} objectForKey:gravityStr];
        if(gravity) {
            _gravity = [gravity intValue];
        } else {
            _gravity = NCGravityTopLeft;
        }
        
        _minWidth = [attributes objectForKey:@"minWidth"];
        _minHeight = [attributes objectForKey:@"minHeight"];
        _maxWidth = [attributes objectForKey:@"maxWidth"];
        _maxHeight = [attributes objectForKey:@"maxHeight"];
        
        _topPadding = [attributes objectForKey:@"topPadding"];
        _rightPadding = [attributes objectForKey:@"rightPadding"];
        _bottomPadding = [attributes objectForKey:@"bottomPadding"];
        _leftPadding = [attributes objectForKey:@"leftPadding"];
        
        _sid = [attributes objectForKey:@"id"];
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    CGRect padding = [self padding];
    bounds = CGSizeMake(MAX(bounds.width - padding.origin.x - padding.size.width, 0),
                        MAX(bounds.height - padding.origin.y - padding.size.height, 0));
    return [self applyPaddingOnRendition:[platform createRenditionWithBounds:bounds]
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    return [self sizeAfterAdjustmentsForSize:bounds
                            withParentBounds:bounds];
}

- (CGSize)sizeAfterAdjustmentsForSize:(CGSize)size
                     withParentBounds:(CGSize)bounds
{
    size = [self sizeAppendingPaddingForBounds:size
                               forParentBounds:bounds];
    
    return [self sizeRespectingMinMaxValuesForBounds:size
                                     forParentBounds:bounds];
}

- (NCGraphic *)findGraphicWithId:(NSString *)sid
{
    return ([self.sid isEqualToString:sid] ? self : nil);
}

- (NCCanvas *)getCanvas
{
    return nil;
}

- (void)addChild:(NCGraphic *)child
{
}

- (void)insertChild:(NCGraphic *)child atIndex:(NSUInteger)index
{
}

- (void)removeChild:(NCGraphic *)child
{
}

@end
