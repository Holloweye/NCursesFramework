//
//  NCCanvas.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCanvas.h"
#import "NCGraphic+Bounds.h"
#import "NCRendition.h"
#import "NCPlatform.h"

@implementation NCCanvas

- (instancetype)init
{
    self = [super init];
    if(self) {
        _children = [NSMutableArray array];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        _children = [NSMutableArray array];
    }
    return self;
}

- (NCGraphic *)findGraphicWithId:(NSString *)sid
{
    NCGraphic *graphic = nil;
    if([self.sid isEqualToString:sid]) {
        graphic = self;
    }
    
    for(int i = 0; i < _children.count && graphic == nil; i++) {
        NCGraphic *child = [_children objectAtIndex:i];
        graphic = [child findGraphicWithId:sid];
    }
    return graphic;
}

- (NCCanvas *)getCanvas
{
    return self;
}

- (void)addChild:(NCGraphic *)child
{
    [_children addObject:child];
}

- (void)insertChild:(NCGraphic *)child atIndex:(NSUInteger)index
{
    [_children insertObject:child atIndex:index];
}

- (void)removeChild:(NCGraphic *)child
{
    [_children removeObject:child];
}

- (void)removeAllChildren
{
    [_children removeAllObjects];
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    CGRect padding = [self padding];
    bounds = CGSizeMake(MAX(bounds.width - padding.origin.x - padding.size.width, 0),
                        MAX(bounds.height - padding.origin.y - padding.size.height, 0));
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    return [self sizeAfterAdjustmentsForSize:bounds
                            withParentBounds:bounds];
}

@end
