//
//  NCCursesRendition.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCursesRendition.h"
#import "NCColor.h"

#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>
#include <curses.h>

@interface NCCursesRendition ()
{
    CGSize size;
    int *matrix;
}
@end

@implementation NCCursesRendition

- (id)initWithBounds:(CGSize)bounds
{
    self = [super initWithBounds:bounds];
    if(self) {
        size = bounds;
        matrix = NULL;
        if(bounds.width > 0 && bounds.height > 0) {
            matrix = (int*)calloc((int)bounds.width * (int)bounds.height, sizeof(int));
        }
    }
    return self;
}

- (void)dealloc
{
    size = CGSizeZero;
    if(matrix != NULL) {
        free(matrix);
        matrix = NULL;
    }
}

- (CGSize)bounds
{
    return size;
}

- (void)setCharacter:(char)c
                  at:(CGSize)pos
      withForeground:(Color)foreground
      withBackground:(Color)background
{
    if(matrix != NULL && pos.width < size.width && pos.height < size.height) {
        matrix[(int)pos.width * (int)size.height + (int)pos.height] = c + foreground * 1000 + background * 10000;
    }
}

- (int)fgForPos:(CGSize)pos
{
    int v = 0;
    if(matrix != NULL && pos.width < size.width && pos.height < size.height) {
        v = matrix[(int)pos.width * (int)size.height + (int)pos.height] % 10000 / 1000;
    }
    return v;
}

- (int)bgForPos:(CGSize)pos
{
    int v = 0;
    if(matrix != NULL && pos.width < size.width && pos.height < size.height) {
        v = matrix[(int)pos.width * (int)size.height + (int)pos.height] / 10000;
    }
    return v;
}

- (char)charForPos:(CGSize)pos
{
    int v = 0;
    if(matrix != NULL && pos.width < size.width && pos.height < size.height) {
        v = matrix[(int)pos.width * (int)size.height + (int)pos.height] % 1000;
    }
    return v;
}

- (void)mergeRendition:(NCCursesRendition *)rendition
               inFrame:(CGRect)frame
{
    if(rendition && matrix != NULL) {
        for(int y = 0; y < MIN(frame.size.height, rendition.bounds.height); y++) {
            for(int x = 0; x < MIN(frame.size.width, rendition.bounds.width); x++) {
                CGSize pos = CGSizeMake(x, y);
                [self setCharacter:[rendition charForPos:pos]
                                at:CGSizeMake(x+frame.origin.x, y+frame.origin.y)
                    withForeground:[rendition fgForPos:pos]
                    withBackground:[rendition bgForPos:pos]];
            }
        }
    }
}

- (void)drawToScreen
{
    erase();
    if(matrix != NULL) {
        for(int x = 0; x < size.width; x++) {
            for(int y = 0; y < size.height; y++) {
                
                const int i = x * (int)size.height + y;
                const int v = *(matrix + i);
                
                int bg, fg;
                char c;
                if(v > 0) {
                    bg = v / 10000;
                    fg = v % 10000 / 1000;
                    c = v % 1000;
                } else {
                    bg = ColorBlack;
                    fg = ColorWhite;
                    c = ' ';
                }
                
                attron(COLOR_PAIR(fg + bg * 10));
                mvaddch(y, x, c);
                attroff(COLOR_PAIR(fg + bg * 10));
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
