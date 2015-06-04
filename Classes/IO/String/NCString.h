//
//  NCString.h
//  NCursesF
//
//  Created by Christer on 2015-02-17.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCColor.h"

@interface NCString : NSObject

- (id)initWithText:(NSString*)text
    withBackground:(NCColor*)background
    withForeground:(NCColor*)foreground;

- (void)setForeground:(NCColor*)foreground
                   at:(NSRange)range;

- (void)setBackground:(NCColor*)background
                   at:(NSRange)range;

@property (readonly) NSUInteger length;

- (char)getCharAtIndex:(NSUInteger)index;
- (Color)getFgAtIndex:(NSUInteger)index;
- (Color)getBgAtIndex:(NSUInteger)index;

- (NCString*)substringToIndex:(NSUInteger)index;
- (NCString*)substringFromIndex:(NSUInteger)index;

- (NSArray*)componentsSeparatedByCharactersInSet:(NSCharacterSet*)characterSet;

- (NCString*)appendHeadText:(NCString *)text;
- (NCString*)appendTailText:(NCString *)text;

- (char)characterAtIndex:(NSUInteger)index;

@end
