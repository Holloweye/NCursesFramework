//
//  NCGraphic+Bounds.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 22/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic+Bounds.h"
#import "NCEvaluate.h"

@implementation NCGraphic (Bounds)

- (CGSize)sizeRespectingMinMaxValuesForBounds:(CGSize)myBounds
                              forParentBounds:(CGSize)parentBounds
{
    int w = myBounds.width;
    int h = myBounds.height;
    
    NSDictionary *words = @{@"parentWidth":[NSNumber numberWithInt:parentBounds.width],
                            @"parentHeight":[NSNumber numberWithInt:parentBounds.height]};
    
    if(self.minWidth) {
        int minW = [NCEvaluate evaluate:self.minWidth
                              variables:words];
        if(w < minW && parentBounds.width >= minW) {
            w = minW;
        }
    }
    if(self.minHeight) {
        int minH = [NCEvaluate evaluate:self.minHeight
                              variables:words];
        if(h < minH && parentBounds.height >= minH) {
            h = minH;
        }
    }
    
    if(self.maxWidth) {
        int maxW = [NCEvaluate evaluate:self.maxWidth
                              variables:words];
        if(w > maxW) {
            w = maxW;
        }
    }
    if(self.maxHeight) {
        int maxH = [NCEvaluate evaluate:self.maxHeight
                              variables:words];
        if(h > maxH) {
            h = maxH;
        }
    }
    
    return CGSizeMake(w,h);
}

@end
