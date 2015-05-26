//
//  NCCursesRendition.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCursesRendition.h"
#import "NCRendition_Protected.h"
#import "NCMatrix.h"
#import "NCRender.h"

#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>
#include <curses.h>

@implementation NCCursesRendition

- (void)drawToScreen
{
    erase();
    for(int x = 0; x < self.matrix.size.width; x++) {
        for(int y = 0; y < self.matrix.size.height; y++) {
            int bcolor = COLOR_BLACK;
            
            NCRender *render = [self.matrix objectAtPos:CGSizeMake(x, y)];
            if([render isKindOfClass:[NCRender class]]) {
                if(render.background) {
                    bcolor = render.background.color;
                }
                
                int fcolor = COLOR_WHITE;
                if(render.foreground) {
                    fcolor = render.foreground.color;
                }
                
                attron(COLOR_PAIR(fcolor + bcolor * 10));
                mvaddch(y, x, render.character);
                attroff(COLOR_PAIR(fcolor + bcolor * 10));
            }
        }
    }
}

+ (CGSize)screenSize
{
    struct winsize w;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
    
    return CGSizeMake(w.ws_col, w.ws_row);
}

@end
