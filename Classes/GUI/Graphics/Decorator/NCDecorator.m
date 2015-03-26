//
//  NCDecorator.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDecorator.h"

@implementation NCDecorator

- (id)initWithGraphic:(NCGraphic *)graphic
{
    self = [super init];
    if(self) {
        _graphic = graphic;
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    return [_graphic drawInBounds:bounds
                     withPlatform:platform];
}

@end
