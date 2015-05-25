//
//  NCSpacer.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 25/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCSpacer.h"
#import "NCRendition.h"
#import "NCPlatform.h"
#import "NCGraphic+Bounds.h"

@implementation NCSpacer

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.character = ' ';
        self.background = [NCColor blackColor];
        self.foreground = [NCColor whiteColor];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if(self) {
        NSString *c = [attributes objectForKey:@"character"];
        if(c && c.length > 0) {
            self.character = [c characterAtIndex:0];
        } else {
            self.character = ' ';
        }
        
        self.background = [NCColor colorFromString:[attributes objectForKey:@"background"]];
        self.foreground = [NCColor colorFromString:[attributes objectForKey:@"foreground"]];
        
        self.background = (self.background ? self.background : [NCColor blackColor]);
        self.foreground = (self.foreground ? self.foreground : [NCColor whiteColor]);
    }
    return self;
}

- (NCRendition *)drawInBounds:(CGSize)bounds
                 withPlatform:(NCPlatform *)platform
{
    NCRendition *rendition = [platform createRenditionWithBounds:bounds];
    for(int y = 0; y < bounds.height; y++) {
        for(int x = 0; x < bounds.width; x++) {
            [rendition setCharacter:self.character
                                 at:CGSizeMake(x, y)
                     withForeground:self.foreground
                     withBackground:self.background];
        }
    }
    return [self applyPaddingOnRendition:rendition
                            withPlatform:platform];
}

- (CGSize)sizeWithinBounds:(CGSize)bounds
{
    return [self sizeAfterAdjustmentsForSize:bounds
                            withParentBounds:bounds];
}

@end
