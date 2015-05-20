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

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if(self) {
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
