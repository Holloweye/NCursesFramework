//
//  NCCursesPlatform.m
//  NCursesFramework
//
//  Created by Christer on 2015-03-26.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCursesPlatform.h"
#import "NCKey.h"
#import "NCCursesRendition.h"
#import <curses.h>

@implementation NCCursesPlatform

static NCCursesPlatform *instance = nil;
+ (NCCursesPlatform *)factory
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NCCursesPlatform alloc] init];
    });
    return instance;
}

- (NCKey *)getKey
{
    char c = getch();
    return [NCKey getKeyFromChar:c];
}

- (NCRendition *)createRenditionWithBounds:(CGSize)bounds
{
    return [[NCCursesRendition alloc] initWithBounds:bounds];
}

- (CGSize)screenSize
{
    return [NCCursesRendition screenSize];
}

@end
