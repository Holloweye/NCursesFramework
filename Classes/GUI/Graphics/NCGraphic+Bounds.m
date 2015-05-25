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

- (CGSize)sizeAppendingPaddingForBounds:(CGSize)myBounds
                        forParentBounds:(CGSize)parentBounds
{
    NSDictionary *words = @{};
    
    CGRect margin = CGRectMake(self.leftPadding ? [NCEvaluate evaluate:[self leftPadding]
                                                             variables:words] : 0,
                               self.topPadding ? [NCEvaluate evaluate:[self topPadding]
                                                            variables:words] : 0,
                               self.rightPadding ? [NCEvaluate evaluate:[self rightPadding]
                                                              variables:words] : 0,
                               self.bottomPadding ? [NCEvaluate evaluate:[self bottomPadding]
                                                               variables:words] : 0);
    
    return CGSizeMake(myBounds.width + margin.origin.x + margin.size.width,
                      myBounds.height + margin.origin.y + margin.size.height);
}

- (NCRendition *)applyPaddingOnRendition:(NCRendition*)rendition
                            withPlatform:(NCPlatform*)platform
{
    CGRect margin = CGRectMake(self.leftPadding ? [NCEvaluate evaluate:[self leftPadding]
                                                             variables:nil] : 0,
                               self.topPadding ? [NCEvaluate evaluate:[self topPadding]
                                                            variables:nil] : 0,
                               self.rightPadding ? [NCEvaluate evaluate:[self rightPadding]
                                                              variables:nil] : 0,
                               self.bottomPadding ? [NCEvaluate evaluate:[self bottomPadding]
                                                               variables:nil] : 0);
    
    NCRendition *rend;
    if(margin.origin.x != 0 || margin.origin.y != 0 || margin.size.width != 0 || margin.size.height != 0) {
        rend = [platform createRenditionWithBounds:CGSizeMake(rendition.bounds.width + margin.origin.x + margin.size.width,
                                                              rendition.bounds.height + margin.origin.y + margin.size.height)];
        [rend mergeRendition:rendition
                     inFrame:CGRectMake(margin.origin.x,
                                        margin.origin.y,
                                        rendition.bounds.width,
                                        rendition.bounds.height)];
    } else {
        rend = rendition;
    }
    return rend;
}

@end
