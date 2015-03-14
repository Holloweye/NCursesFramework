//
//  NCString.h
//  NCursesF
//
//  Created by Christer on 2015-02-17.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCColor.h"

@interface NCChar : NSObject
@property (nonatomic, assign) char c;
@property (nonatomic, strong) NCColor *foreground;
@property (nonatomic, strong) NCColor *background;
@end

@interface NCString : NSObject

- (id)initWithText:(NSString*)text
    withBackground:(NCColor*)background
    withForeground:(NCColor*)foreground;

- (void)setForeground:(NCColor*)foreground
                   at:(NSRange)range;

- (void)setBackground:(NCColor*)background
                   at:(NSRange)range;

@property (readonly) NSUInteger length;

- (NCChar*)getCharAtIndex:(NSUInteger)index;
- (NCString*)substringToIndex:(NSUInteger)index;
- (NCString*)substringFromIndex:(NSUInteger)index;
- (NSArray*)componentsSeparatedByCharactersInSet:(NSCharacterSet*)characterSet;
- (NCString*)appendHeadText:(NCString *)text;
- (NCString*)appendTailText:(NCString *)text;
- (char)characterAtIndex:(NSUInteger)index;

@end
