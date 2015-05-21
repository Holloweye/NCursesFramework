//
//  NCGraphic.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCPlatform.h"

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
            self.gravity = [gravity intValue];
        } else {
            self.gravity = NCGravityTopLeft;
        }
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    return [platform createRenditionWithBounds:bounds];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    return CGSizeMake(0, 0);
}

- (NCCanvas *)getCanvas
{
    return nil;
}

- (void)addChild:(NCGraphic *)child
{
}

- (void)removeChild:(NCGraphic *)child
{
}

@end
