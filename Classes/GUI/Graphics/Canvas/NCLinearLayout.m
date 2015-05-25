//
//  NCLinearLayout.m
//  NCursesFramework
//
//  Created by Christer on 2015-03-26.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCLinearLayout.h"
#import "NCGraphic+Bounds.h"
#import "NCRendition.h"
#import "NCPlatform.h"

@interface NCLinearLayoutElement : NSObject
@property (nonatomic, strong) NCGraphic *grapic;
@property (nonatomic, assign) CGSize bounds;
@end

@implementation NCLinearLayoutElement
@end

@implementation NCLinearLayout

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.orientation = NCLinearLayoutOrientationVertical;
    }
    return self;
}

- (id)initWithOrientation:(NCLinearLayoutOrientation)orientation
{
    self = [super init];
    if(self) {
        self.orientation = orientation;
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        NSString *orientation = [attributes objectForKey:@"orientation"];
        if(orientation && [orientation isEqualToString:@"horizontal"]) {
            self.orientation = NCLinearLayoutOrientationHorizontal;
        } else {
            self.orientation = NCLinearLayoutOrientationVertical;
        }
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = nil;
    
    NSMutableArray *graphicsToDraw = [NSMutableArray array];
    
    CGSize totalSize = (self.orientation == NCLinearLayoutOrientationVertical ? CGSizeMake(bounds.width, 0) : CGSizeMake(0, bounds.height));
    for(NCGraphic *graphic in self.children)
    {
        NCLinearLayoutElement *element = [[NCLinearLayoutElement alloc] init];
        element.grapic = graphic;
        if(self.orientation == NCLinearLayoutOrientationVertical)
        {
            element.bounds = [graphic sizeWithinBounds:CGSizeMake(bounds.width, NSIntegerMax)];
            
            BOOL isWithinBounds = totalSize.height + element.bounds.height <= bounds.height;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width, totalSize.height + element.bounds.height);
                [graphicsToDraw addObject:element];
            }
        }
        else if(self.orientation == NCLinearLayoutOrientationHorizontal)
        {
            element.bounds = [graphic sizeWithinBounds:CGSizeMake(NSIntegerMax, bounds.height)];
            
            BOOL isWithinBounds = totalSize.width + element.bounds.width <= bounds.width;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width + element.bounds.width, totalSize.height);
                [graphicsToDraw addObject:element];
            }
        }
    }
    rendition = [platform createRenditionWithBounds:totalSize];
    
    int offset = 0;
    for(NCLinearLayoutElement *element in graphicsToDraw)
    {
        NCRendition *rend = [element.grapic drawInBounds:element.bounds
                                            withPlatform:platform];
        if(self.orientation == NCLinearLayoutOrientationVertical)
        {
            int xOffset = 0;
            if(element.grapic.gravity == NCGravityBottomCenter ||
               element.grapic.gravity == NCGravityMiddleCenter ||
               element.grapic.gravity == NCGravityTopCenter) {
                xOffset = (bounds.width - rend.bounds.width) / 2;
            } else if(element.grapic.gravity == NCGravityBottomRight ||
                      element.grapic.gravity == NCGravityMiddleRight ||
                      element.grapic.gravity == NCGravityTopRight) {
                xOffset = (bounds.width - rend.bounds.width);
            }
            
            [rendition mergeRendition:rend
                              inFrame:CGRectMake(xOffset,
                                                 offset,
                                                 rend.bounds.width,
                                                 rend.bounds.height)];
            offset += rend.bounds.height;
        }
        else if(self.orientation == NCLinearLayoutOrientationHorizontal)
        {
            int yOffset = 0;
            if(element.grapic.gravity == NCGravityMiddleCenter ||
               element.grapic.gravity == NCGravityMiddleLeft ||
               element.grapic.gravity == NCGravityMiddleRight) {
                yOffset = (bounds.height - rend.bounds.height) / 2;
            } else if(element.grapic.gravity == NCGravityBottomCenter ||
                      element.grapic.gravity == NCGravityBottomLeft ||
                      element.grapic.gravity == NCGravityBottomRight) {
                yOffset = (bounds.height - rend.bounds.height);
            }
            
            [rendition mergeRendition:rend
                              inFrame:CGRectMake(offset,
                                                 yOffset,
                                                 rend.bounds.width,
                                                 rend.bounds.height)];
            offset += rend.bounds.width;
        }
    }
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize totalSize = CGSizeMake(0, 0);
    
    for(NCGraphic *graphic in self.children)
    {
        if(self.orientation == NCLinearLayoutOrientationVertical)
        {
            CGSize size = [graphic sizeWithinBounds:CGSizeMake(bounds.width, NSIntegerMax)];
            
            BOOL isWithinBounds = totalSize.height + size.height <= bounds.height;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width, totalSize.height + size.height);
            }
            
            if(size.width > totalSize.width && size.width < bounds.width) {
                totalSize = CGSizeMake(size.width, totalSize.height);
            }
        }
        else if(self.orientation == NCLinearLayoutOrientationHorizontal)
        {
            CGSize size = [graphic sizeWithinBounds:CGSizeMake(NSIntegerMax, bounds.height)];
            
            BOOL isWithinBounds = totalSize.width + size.width <= bounds.width;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width + size.width, totalSize.height);
            }
            
            if(size.height > totalSize.height && size.height < bounds.height) {
                totalSize = CGSizeMake(totalSize.width, size.height);
            }
        }
    }
    return [self sizeAfterAdjustmentsForSize:totalSize
                            withParentBounds:bounds];
}

@end
