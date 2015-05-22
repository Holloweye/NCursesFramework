//
//  NCBorderDecorator.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCBorderDecorator.h"
#import "NCGraphic+Bounds.h"
#import "NCRendition.h"
#import "NCBorderStrategy.h"
#import "NCBorderFilledStrategy.h"
#import "NCBorderDottedStrategy.h"
#import "NCRender.h"
#import "NCPlatform.h"

@implementation NCBorderDecorator

- (instancetype)init
{
    self = [super init];
    if(self) {
        _strategy = [[NCBorderFilledStrategy alloc] init];
    }
    return self;
}

- (id)initWithGraphic:(NCGraphic *)graphic
{
    self = [super initWithGraphic:graphic];
    if(self) {
        _strategy = [[NCBorderFilledStrategy alloc] init];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        BOOL filled = YES;
        char nw = '+';
        char ne = '+';
        char sw = '+';
        char se = '+';
        char n = '-';
        char e = '|';
        char s = '-';
        char w = '|';
        int spacing = 2;
        NCColor *bg = [NCColor blackColor];
        NCColor *fg = [NCColor whiteColor];
        
        if([[attributes objectForKey:@"type"] isEqualToString:@"dotted"]) {
            filled = NO;
        }
        
        NSString *nwStr = [attributes objectForKey:@"nw"];
        nw = (nwStr.length > 0 ? [nwStr characterAtIndex:0] : nw);
        
        NSString *neStr = [attributes objectForKey:@"ne"];
        ne = (neStr.length > 0 ? [neStr characterAtIndex:0] : ne);
        
        NSString *swStr = [attributes objectForKey:@"sw"];
        sw = (swStr.length > 0 ? [swStr characterAtIndex:0] : sw);
        
        NSString *seStr = [attributes objectForKey:@"se"];
        se = (seStr.length > 0 ? [seStr characterAtIndex:0] : se);
        
        NSString *nStr = [attributes objectForKey:@"n"];
        n = (nStr.length > 0 ? [nStr characterAtIndex:0] : n);
        
        NSString *eStr = [attributes objectForKey:@"e"];
        e = (eStr.length > 0 ? [eStr characterAtIndex:0] : e);
        
        NSString *sStr = [attributes objectForKey:@"s"];
        s = (sStr.length > 0 ? [sStr characterAtIndex:0] : s);
        
        NSString *wStr = [attributes objectForKey:@"w"];
        w = (wStr.length > 0 ? [wStr characterAtIndex:0] : w);
        
        bg = [NCColor colorFromString:[attributes objectForKey:@"background"]];
        fg = [NCColor colorFromString:[attributes objectForKey:@"foreground"]];
        
        bg = (bg ? bg : [NCColor blackColor]);
        fg = (fg ? fg : [NCColor whiteColor]);
        
        NSString *spacingStr = [attributes objectForKey:@"spacing"];
        spacing = (spacingStr.length > 0 ? [spacingStr intValue] : spacing);
        
        if(filled) {
            _strategy = [[NCBorderFilledStrategy alloc] initWithCornerNW:nw
                                                            withCornerNE:ne
                                                            withCornerSW:sw
                                                            withCornerSE:se
                                                                   withN:n
                                                                   withE:e
                                                                   withS:s
                                                                   withW:w
                                                          withBackground:bg
                                                          withForeground:fg];
        } else {
            _strategy = [[NCBorderDottedStrategy alloc] initWithCornerNW:nw
                                                            withCornerNE:ne
                                                            withCornerSW:sw
                                                            withCornerSE:se
                                                                   withN:n
                                                                   withE:e
                                                                   withS:s
                                                                   withW:w
                                                             withSpacing:spacing
                                                          withBackground:bg
                                                          withForeground:fg];
        }
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    
    if(self.graphic && bounds.width > 2 && bounds.height > 2) {
        NCRendition *graphicRendition = [self.graphic drawInBounds:CGSizeMake(bounds.width-2, bounds.height-2)
                                                      withPlatform:platform];
        [rendition mergeRendition:graphicRendition
                          inFrame:CGRectMake(1, 1, bounds.width-2, bounds.width-2)];
    }
    
    if(self.strategy) {
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(bounds.width, MIN(1, bounds.height))
                                                 withPlatform:platform
                                                     position:NCBorderPositionTop]
                          inFrame:CGRectMake(0, 0, bounds.width, MIN(bounds.height, 1))];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(MIN(1, bounds.width), bounds.height)
                                                 withPlatform:platform
                                                     position:NCBorderPositionLeft]
                          inFrame:CGRectMake(0, 0, MIN(bounds.width, 1), bounds.height)];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(bounds.width, MIN(1, bounds.height))
                                                 withPlatform:platform
                                                     position:NCBorderPositionBottom]
                          inFrame:CGRectMake(0, bounds.height-1, bounds.width, MIN(bounds.height, 1))];
        
        [rendition mergeRendition:[self.strategy drawInBounds:CGSizeMake(MIN(1, bounds.width), bounds.height)
                                                 withPlatform:platform
                                                     position:NCBorderPositionRight]
                          inFrame:CGRectMake(bounds.width-1, 0, MIN(bounds.width, 1), bounds.height)];
    }
    
    return rendition;
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    CGSize size = CGSizeZero;
    if(self.graphic) {
        size = [self.graphic sizeWithinBounds:bounds];
        size = CGSizeMake(size.width+2, size.height+2);
    }
    size = CGSizeMake(MIN(bounds.width, size.width), MIN(bounds.height, size.height));
    return [self sizeRespectingMinMaxValuesForBounds:size
                                     forParentBounds:bounds];
}

@end
