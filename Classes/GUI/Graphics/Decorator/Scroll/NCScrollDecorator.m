//
//  NCScrollDecorator.m
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCScrollDecorator.h"
#import "NCRendition.h"
#import "NCScrollBarStrategy.h"
#import "NCColor.h"
#import "NCPlatform.h"

@implementation NCScrollDecorator

- (instancetype)init
{
    self = [super init];
    if(self) {
        _background = [NCColor blackColor];
        _offset = CGSizeZero;
        _orientation = NCScrollOrientationVertical;
    }
    return self;
}

- (instancetype)initWithGraphic:(NCGraphic *)graphic
{
    self = [super initWithGraphic:graphic];
    if(self) {
        _background = [NCColor blackColor];
        _offset = CGSizeZero;
        _orientation = NCScrollOrientationVertical;
    }
    return self;
}

- (void)setOffset:(CGSize)offset
{
    _offset = CGSizeMake(MIN(0, offset.width), MIN(0, offset.height));
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    if(self.graphic) {
        if(_orientation == NCScrollOrientationVertical) {
            CGSize size = [self.graphic sizeWithinBounds:CGSizeMake(bounds.width-(self.strategy?1:0), NSIntegerMax)];
            
            NCRendition *graphicRendition = [self.graphic drawInBounds:CGSizeMake(MAX(size.width, bounds.width-(self.strategy?1:0)),
                                                                                  MAX(size.height, bounds.height))
                                                          withPlatform:platform];
            
            _offset = CGSizeMake(MIN(MAX(0-(graphicRendition.bounds.width-bounds.width), _offset.width),0),
                                 MIN(MAX(0-(graphicRendition.bounds.height-bounds.height), _offset.height),0));
            
            [rendition mergeRendition:graphicRendition
                              inFrame:CGRectMake(_offset.width,
                                                 _offset.height,
                                                 graphicRendition.bounds.width,
                                                 graphicRendition.bounds.height)];
            
            int scrollMax = graphicRendition.bounds.height > bounds.height ? graphicRendition.bounds.height - bounds.height : 0;
            int scrollPos = abs(MAX(_offset.height, 0-scrollMax));
            
            if(_strategy) {
                NCRendition *barRendition = [_strategy drawInBounds:CGSizeMake(1, bounds.height)
                                                       withPlatform:platform
                                                                pos:scrollPos
                                                                max:scrollMax];
                [rendition mergeRendition:barRendition
                                  inFrame:CGRectMake(bounds.width - barRendition.bounds.width,
                                                     0,
                                                     barRendition.bounds.width,
                                                     barRendition.bounds.height)];
            }
        } else {
            CGSize size = [self.graphic sizeWithinBounds:CGSizeMake(NSIntegerMax, bounds.height-(self.strategy?1:0))];
            NCRendition *graphicRendition = [self.graphic drawInBounds:CGSizeMake(MAX(size.width, bounds.width),
                                                                                  MAX(size.height, bounds.height-(self.strategy?1:0)))
                                                          withPlatform:platform];
            
            _offset = CGSizeMake(MIN(MAX(0-(graphicRendition.bounds.width-bounds.width), _offset.width),0),
                                 MIN(MAX(0-(graphicRendition.bounds.height-bounds.height), _offset.height),0));
            
            [rendition mergeRendition:graphicRendition
                              inFrame:CGRectMake(_offset.width,
                                                 _offset.height,
                                                 graphicRendition.bounds.width,
                                                 graphicRendition.bounds.height)];
            
            int scrollMax = graphicRendition.bounds.width > bounds.width ? graphicRendition.bounds.width - bounds.width : 0;
            int scrollPos = abs(MAX(_offset.width, 0-scrollMax));
            
            if(_strategy) {
                NCRendition *barRendition = [_strategy drawInBounds:CGSizeMake(bounds.width, 1)
                                                       withPlatform:platform
                                                                pos:scrollPos
                                                                max:scrollMax];
                [rendition mergeRendition:barRendition
                                  inFrame:CGRectMake(0,
                                                     bounds.height - barRendition.bounds.height,
                                                     barRendition.bounds.width,
                                                     barRendition.bounds.height)];
            }
        }
    }
    return rendition;
}

@end
