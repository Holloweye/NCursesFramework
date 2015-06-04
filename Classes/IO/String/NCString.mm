//
//  NCString.m
//  NCursesF
//
//  Created by Christer on 2015-02-17.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCString.h"
#import "NCString_Protected.hh"

@interface NCString ()
@end

@implementation NCString

- (instancetype)init
{
    self = [super init];
    if(self) {
    }
    return self;
}

- (id)initWithVector:(std::vector<int>)vector
{
    self = [super init];
    if(self) {
        chars = vector;
    }
    return self;
}

- (id)initWithText:(NSString *)text
    withBackground:(NCColor *)background
    withForeground:(NCColor *)foreground
{
    self = [super init];
    if(self) {
        NSUInteger pos = chars.size();
        chars.resize(text.length);
        
        for(int i = 0; i < text.length; i++) {
            char c = [text characterAtIndex:i];
            chars[pos + i] = c + foreground.color * 1000 + background.color * 10000;
        }
    }
    return self;
}

- (void)setForeground:(NCColor *)foreground
                   at:(NSRange)range
{
    if(range.location < chars.size()) {
        for(NSUInteger i = range.location; i < range.location + range.length && i < chars.size(); i++) {
            const int v = chars[i];
            const int bg = v / 10000;
            const int fg = foreground.color;
            const int c = v % 1000;
            
            chars[i] = c + fg * 1000 + bg * 10000;
        }
    }
}

- (void)setBackground:(NCColor *)background
                   at:(NSRange)range
{
    if(range.location < chars.size()) {
        for(NSUInteger i = range.location; i < range.location + range.length && i < chars.size(); i++) {
            const int v = chars[i];
            const int bg = background.color;
            const int fg = v % 10000 / 1000;
            const int c = v % 1000;
            
            chars[i] = c + fg * 1000 + bg * 10000;
        }
    }
}

- (char)getCharAtIndex:(NSUInteger)i
{
    char c = ' ';
    if(i < chars.size()) {
        c = chars[i] % 1000;
    }
    return c;
}

- (Color)getBgAtIndex:(NSUInteger)i
{
    Color bg = ColorBlack;
    if(i < chars.size()) {
        bg = (Color)(chars[i] / 100000);
    }
    return bg;
}

- (Color)getFgAtIndex:(NSUInteger)i
{
    Color bg = ColorWhite;
    if(i < chars.size()) {
        bg = (Color)(chars[i] % 10000 / 1000);
    }
    return bg;
}

- (NSUInteger)length
{
    return chars.size();
}

- (NCString *)substringToIndex:(NSUInteger)index
{
    std::vector<int> copy(chars.begin(), chars.begin() + index);
    return [[NCString alloc] initWithVector:copy];
}

- (NCString *)substringFromIndex:(NSUInteger)index
{
    std::vector<int> copy(chars.begin() + index, chars.end());
    return [[NCString alloc] initWithVector:copy];
}

-(NSArray *)componentsSeparatedByCharactersInSet:(NSCharacterSet *)characterSet
{
    NSMutableArray *components = [NSMutableArray array];
    std::vector<int> *tmp = NULL;
    for(NSUInteger i = 0; i < [self length]; i++) {
        char c = [self getCharAtIndex:i];
        if([characterSet characterIsMember:c]) {
            if(tmp != NULL && tmp->size() > 0) {
                NCString *str = [[NCString alloc] initWithVector:*tmp];
                [components addObject:str];
            }
        } else {
            if(tmp == NULL) {
                tmp = new std::vector<int>();
            }
            tmp->push_back(chars[i]);
        }
        
        BOOL isLast = i+1 == [self length];
        if(isLast && tmp != NULL && tmp->size() > 0) {
            NCString *str = [[NCString alloc] initWithVector:*tmp];
            [components addObject:str];
        }
    }
    tmp = NULL;
    return components;
}

- (NCString *)appendHeadText:(NCString *)text
{
    NCString *append = [[NCString alloc] init];
    for(NSUInteger i = 0; i < text.length; i++) {
        char c = [text characterAtIndex:i];
        Color fg = [text getFgAtIndex:i];
        Color bg = [text getBgAtIndex:i];
        
        chars.insert(chars.begin(), c + fg * 1000 + bg * 10000);
        
    }
    return append;
}

- (NCString *)appendTailText:(NCString *)text
{
    NCString *append = [[NCString alloc] init];
    for(NSUInteger i = text.length-1; i < text.length; i--) {
        char c = [text characterAtIndex:i];
        Color fg = [text getFgAtIndex:i];
        Color bg = [text getBgAtIndex:i];
        
        chars.push_back(c + fg * 1000 + bg * 10000);
    }
    return append;
}

- (char)characterAtIndex:(NSUInteger)index
{
    return (index < chars.size() ? chars[index] % 1000 : 0);
}

@end
