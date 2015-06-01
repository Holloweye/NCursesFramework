//
//  NCString.m
//  NCursesF
//
//  Created by Christer on 2015-02-17.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCString.h"
#import "NCString_Protected.h"

@implementation NCChar
@end

@implementation NCString

- (id)initWithText:(NSString *)text
    withBackground:(NCColor *)background
    withForeground:(NCColor *)foreground
{
    self = [super init];
    if(self) {
        NSMutableArray *tmp = [NSMutableArray array];
        for(int i = 0; i < text.length; i++)
        {
            char c = [text characterAtIndex:i];
            
            NCChar *ch = [[NCChar alloc] init];
            ch.c = c;
            ch.foreground = foreground;
            ch.background = background;
            [tmp addObject:ch];
        }
        self.chars = tmp;
    }
    return self;
}

- (void)setForeground:(NCColor *)foreground
                   at:(NSRange)range
{
    for(NSUInteger i = range.location; i < range.location + range.length; i++) {
        NCChar *c = [self getCharAtIndex:i];
        [c setForeground:foreground];
    }
}

- (void)setBackground:(NCColor *)background
                   at:(NSRange)range
{
    for(NSUInteger i = range.location; i < range.location + range.length; i++) {
        NCChar *c = [self getCharAtIndex:i];
        [c setBackground:background];
    }
}

- (NCChar *)getCharAtIndex:(NSUInteger)index
{
    NCChar *c = nil;
    if(index < self.chars.count) {
        c = [self.chars objectAtIndex:index];
    }
    return c;
}

- (NSUInteger)length
{
    return self.chars.count;
}

- (NCString *)substringToIndex:(NSUInteger)index
{
    NCString *sub = [[NCString alloc] init];
    NSMutableArray *tmp = [NSMutableArray array];
    for(NSUInteger i = 0; i < index; i++) {
        NCChar *c = [self getCharAtIndex:i];
        if(c) {
            [tmp addObject:c];
        }
    }
    sub.chars = tmp;
    return sub;
}

- (NCString *)substringFromIndex:(NSUInteger)index
{
    NCString *sub = [[NCString alloc] init];
    NSMutableArray *tmp = [NSMutableArray array];
    for(NSUInteger i = index; i < [self length]; i++) {
        NCChar *c = [self getCharAtIndex:i];
        if(c) {
            [tmp addObject:c];
        }
    }
    sub.chars = tmp;
    return sub;
}

-(NSArray *)componentsSeparatedByCharactersInSet:(NSCharacterSet *)characterSet
{
    NSMutableArray *components = [NSMutableArray array];
    NSMutableArray *chars = [NSMutableArray array];
    for(NSUInteger i = 0; i < [self length]; i++) {
        NCChar *c = [self getCharAtIndex:i];
        if([characterSet characterIsMember:c.c] && chars.count > 0) {
            NCString *str = [[NCString alloc] init];
            str.chars = chars;
            [components addObject:str];
            chars = [NSMutableArray array];
        } else {
            [chars addObject:c];
        }
    }
    if(chars.count > 0) {
        NCString *str = [[NCString alloc] init];
        str.chars = chars;
        [components addObject:str];
    }
    return components;
}

- (NCString *)appendHeadText:(NCString *)text
{
    NCString *append = [[NCString alloc] init];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:text.chars];
    [tmp addObjectsFromArray:self.chars];
    append.chars = tmp;
    return append;
}

- (NCString *)appendTailText:(NCString *)text
{
    NCString *append = [[NCString alloc] init];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.chars];
    [tmp addObjectsFromArray:text.chars];
    append.chars = tmp;
    return append;
}

- (char)characterAtIndex:(NSUInteger)index
{
    NCChar *c = [self getCharAtIndex:index];
    return c.c;
}

@end
