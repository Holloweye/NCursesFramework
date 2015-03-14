//
//  NCCursesKey.m
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCursesKey.h"
#include <curses.h>

@implementation NCCursesKey

+ (NCKey *)getKey
{
    char c = getch();
    return [NCKey getKeyFromChar:c];
}

@end
