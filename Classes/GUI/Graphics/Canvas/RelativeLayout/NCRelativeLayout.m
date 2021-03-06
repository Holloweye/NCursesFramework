//
//  NCRelativeLayout.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCRelativeLayout.h"
#import "NCGraphic+Bounds.h"
#import "NCRendition.h"
#import "NCPlatform.h"

@implementation NCRelativeLayout

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    CGRect padding = [self padding];
    bounds = CGSizeMake(MAX(bounds.width - padding.origin.x - padding.size.width, 0),
                        MAX(bounds.height - padding.origin.y - padding.size.height, 0));
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    
    for(NCGraphic *child in self.children) {
        NCRendition *childRendition = [child drawInBounds:[child sizeWithinBounds:bounds]
                                             withPlatform:platform];
        CGRect rect = CGRectMake(0, 0, childRendition.bounds.width, childRendition.bounds.height);
        
        if(child.gravity == NCGravityTopLeft ||
           child.gravity == NCGravityMiddleLeft ||
           child.gravity == NCGravityBottomLeft) {
            rect.origin.x = 0;
        } else if(child.gravity == NCGravityTopCenter ||
                  child.gravity == NCGravityMiddleCenter ||
                  child.gravity == NCGravityBottomCenter) {
            rect.origin.x = MAX(floorf(bounds.width / 2 - childRendition.bounds.width / 2), 0);
        } else if(child.gravity == NCGravityTopRight ||
                  child.gravity == NCGravityMiddleRight ||
                  child.gravity == NCGravityBottomRight) {
            rect.origin.x = MAX(bounds.width - childRendition.bounds.width, 0);
        }
        
        if(child.gravity == NCGravityTopLeft ||
           child.gravity == NCGravityTopCenter ||
           child.gravity == NCGravityTopRight) {
            rect.origin.y = 0;
        } else if(child.gravity == NCGravityMiddleLeft ||
                  child.gravity == NCGravityMiddleCenter ||
                  child.gravity == NCGravityMiddleRight) {
            rect.origin.y = MAX(floorf(bounds.height / 2 - childRendition.bounds.height / 2), 0);
        } else if(child.gravity == NCGravityBottomLeft ||
                  child.gravity == NCGravityBottomCenter ||
                  child.gravity == NCGravityBottomRight) {
            rect.origin.y = MAX(bounds.height - childRendition.bounds.height, 0);
        }
        
        [rendition mergeRendition:childRendition
                          inFrame:rect];
    }
    
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize sizes[NCGravityBottomRight+1];
    for(int i = 0; i < NCGravityBottomRight+1; i++) {
        sizes[i] = CGSizeMake(0, 0);
    }
    
    for(NCGraphic *child in self.children) {
        CGSize size = [child sizeWithinBounds:bounds];
        sizes[child.gravity] = CGSizeMake(MAX(size.width, sizes[child.gravity].width),
                                          MAX(size.height, sizes[child.gravity].height));
    }
    
    float width = 0;
    float height = 0;
    
    width += MAX(MAX(sizes[NCGravityTopLeft].width, sizes[NCGravityMiddleLeft].width), sizes[NCGravityBottomLeft].width);
    width += MAX(MAX(sizes[NCGravityTopCenter].width, sizes[NCGravityMiddleCenter].width), sizes[NCGravityBottomCenter].width);
    width += MAX(MAX(sizes[NCGravityTopRight].width, sizes[NCGravityMiddleRight].width), sizes[NCGravityBottomRight].width);
    
    height += MAX(MAX(sizes[NCGravityTopLeft].height, sizes[NCGravityTopCenter].height), sizes[NCGravityTopRight].height);
    height += MAX(MAX(sizes[NCGravityMiddleLeft].height, sizes[NCGravityMiddleCenter].height), sizes[NCGravityMiddleRight].height);
    height += MAX(MAX(sizes[NCGravityBottomLeft].height, sizes[NCGravityBottomCenter].height), sizes[NCGravityBottomRight].height);
    
    CGSize size = CGSizeMake(MIN(width, bounds.width),
                             MIN(height, bounds.height));
    
    return [self sizeAfterAdjustmentsForSize:size
                            withParentBounds:bounds];
}

@end
