//
//  NCCanvas.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCanvas.h"
#import "NCRendition.h"

@interface NCCanvas ()
{
    NSMutableArray *_children;
}
@end

@implementation NCCanvas

- (instancetype)init
{
    self = [super init];
    if(self) {
        _children = [NSMutableArray array];
    }
    return self;
}

- (NCCanvas *)getCanvas
{
    return self;
}

- (void)addChild:(NCGraphic *)child
{
    [_children addObject:child];
}

- (void)removeChild:(NCGraphic *)child
{
    [_children addObject:child];
}

- (NCRendition *)drawInBounds:(CGSize)bounds
{
    NCRendition *rendition = [[NCRendition alloc] initWithBounds:bounds];
    return rendition;
}

@end
