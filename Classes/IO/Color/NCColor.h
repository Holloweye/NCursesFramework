//
//  NCColor.h
//  NCursesLibrary
//
//  Created by Christer on 2014-06-13.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ColorBlack,
    ColorRed,
    ColorGreen,
    ColorYellow,
    ColorBlue,
    ColorMagenta,
    ColorCyan,
    ColorWhite,
    ColorTransparent
} Color;

@interface NCColor : NSObject

- (id) initWithColor:(Color)color;

@property (nonatomic, assign) Color color;

+ (NCColor*) colorFromString:(NSString*)str;

+ (NCColor*) clearColor;
+ (NCColor*) blackColor;
+ (NCColor*) redColor;
+ (NCColor*) greenColor;
+ (NCColor*) yellowColor;
+ (NCColor*) blueColor;
+ (NCColor*) magentaColor;
+ (NCColor*) cyanColor;
+ (NCColor*) whiteColor;

@end
