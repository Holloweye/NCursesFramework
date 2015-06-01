//
//  NCMutableString.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCMutableString.h"
#import "NCString_Protected.h"

@implementation NCMutableString

- (void)addCharacter:(char)c
      withBackground:(NCColor *)background
      withForeground:(NCColor *)foreground
{
    NCChar *ch = [[NCChar alloc] init];
    ch.c = c;
    ch.foreground = (foreground ? foreground : [NCColor whiteColor]);
    ch.background = (background ? background : [NCColor blackColor]);
    [self.chars addObject:ch];
}

- (void)insertCharacter:(char)c
         withBackground:(NCColor *)background
         withForeground:(NCColor *)foreground
                atIndex:(NSUInteger)index
{
    NCChar *ch = [[NCChar alloc] init];
    ch.c = c;
    ch.foreground = (foreground ? foreground : [NCColor whiteColor]);
    ch.background = (background ? background : [NCColor blackColor]);
    [self.chars insertObject:ch atIndex:index];
}

- (void)deleteCharacterAtIndex:(NSUInteger)index
{
    [self.chars removeObjectAtIndex:index];
}

@end
