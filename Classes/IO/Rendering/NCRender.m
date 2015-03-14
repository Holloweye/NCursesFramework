//
//  NCRender.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-16.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "NCRender.h"

@implementation NCRender

- (id)initWithCharacter:(char)c
         withBackground:(NCColor *)background
         withForeground:(NCColor *)foreground
{
    self = [super init];
    if(self) {
        _character = c;
        _background = background;
        _foreground = foreground;
    }
    return self;
}

- (id) init
{
    self = [super init];
    if(self) {
        _character = ' ';
    }
    return self;
}

@end
