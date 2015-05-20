//
//  NCColor.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-13.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "NCColor.h"

@implementation NCColor

- (id)initWithColor:(Color)color
{
    self = [super init];
    if(self) {
        self.color = color;
    }
    return self;
}

+ (NCColor *)colorFromString:(NSString *)str
{
    NCColor *c = nil;
    if(str) {
        c = [@{@"clear"     :[NCColor clearColor],
               @"black"     :[NCColor blackColor],
               @"red"       :[NCColor redColor],
               @"green"     :[NCColor greenColor],
               @"yellow"    :[NCColor yellowColor],
               @"blue"      :[NCColor blueColor],
               @"magenta"   :[NCColor magentaColor],
               @"cyan"      :[NCColor cyanColor],
               @"white"     :[NCColor whiteColor]} objectForKey:str];
    }
    return c;
}

+ (NCColor*) clearColor
{
    return [[NCColor alloc] initWithColor:ColorTransparent];
}

+ (NCColor*) blackColor
{
    return [[NCColor alloc] initWithColor:ColorBlack];
}

+ (NCColor*) redColor
{
    return [[NCColor alloc] initWithColor:ColorRed];
}

+ (NCColor*) greenColor
{
    return [[NCColor alloc] initWithColor:ColorGreen];
}

+ (NCColor*) yellowColor
{
    return [[NCColor alloc] initWithColor:ColorYellow];
}

+ (NCColor*) blueColor
{
    return [[NCColor alloc] initWithColor:ColorBlue];
}

+ (NCColor*) magentaColor
{
    return [[NCColor alloc] initWithColor:ColorMagenta];
}

+ (NCColor*) cyanColor
{
    return [[NCColor alloc] initWithColor:ColorCyan];
}

+ (NCColor*) whiteColor
{
    return [[NCColor alloc] initWithColor:ColorWhite];
}

@end
