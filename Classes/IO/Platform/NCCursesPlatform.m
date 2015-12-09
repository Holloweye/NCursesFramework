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

+ (void)initialize
{
    [super initialize];
    
    initscr();
    curs_set(0);
    start_color();
    raw();
    keypad(stdscr, TRUE);
    noecho();
    
    // init color pairs
    for(int f = 0; f <= 7; f++) {
        for(int b = 0; b <= 7; b++) {
            int colorCode = f + b * 10;
            init_pair(colorCode, f, b);
        }
    }
}

- (void)dealloc
{
    endwin();
}

- (NCKey *)getKey
{
    char c1 = getch();
    timeout(0);
    char c2 = getch();
    char c3 = getch();
    char c4 = getch();
    timeout(-1);
    return [NCKey getKeyFromChar1:c1
                            char2:c2
                            char3:c3
                            char4:c4];
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
