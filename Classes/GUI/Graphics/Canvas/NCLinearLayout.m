//
//  NCLinearLayout.m
//  NCursesFramework
//
//  Created by Christer on 2015-03-26.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCLinearLayout.h"
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
            [rendition mergeRendition:rend
                              inFrame:CGRectMake(0,
                                                 offset,
                                                 rend.bounds.width,
                                                 rend.bounds.height)];
            offset += rend.bounds.height;
        }
        else if(self.orientation == NCLinearLayoutOrientationHorizontal)
        {
            [rendition mergeRendition:rend
                              inFrame:CGRectMake(offset,
                                                 0,
                                                 rend.bounds.width,
                                                 rend.bounds.height)];
            offset += rend.bounds.width;
        }
    }
    return rendition;
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize totalSize = (self.orientation == NCLinearLayoutOrientationVertical ? CGSizeMake(bounds.width, 0) : CGSizeMake(0, bounds.height));
    
    for(NCGraphic *graphic in self.children)
    {
        if(self.orientation == NCLinearLayoutOrientationVertical)
        {
            CGSize size = [graphic sizeWithinBounds:CGSizeMake(bounds.width, NSIntegerMax)];
            
            BOOL isWithinBounds = totalSize.height + size.height <= bounds.height;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width, totalSize.height + size.height);
            }
        }
        else if(self.orientation == NCLinearLayoutOrientationHorizontal)
        {
            CGSize size = [graphic sizeWithinBounds:CGSizeMake(NSIntegerMax, bounds.height)];
            
            BOOL isWithinBounds = totalSize.width + size.width <= bounds.width;
            if(isWithinBounds) {
                totalSize = CGSizeMake(totalSize.width + size.width, totalSize.height);
            }
        }
    }
    return totalSize;
}

@end
