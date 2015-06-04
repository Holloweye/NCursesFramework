//
//  NCMutableString.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCMutableString.h"
#import "NCString_Protected.hh"

@implementation NCMutableString

- (void)addCharacter:(char)c
      withBackground:(NCColor *)background
      withForeground:(NCColor *)foreground
{
    chars.push_back(c + foreground.color * 1000 + background.color * 10000);
}

- (void)insertCharacter:(char)c
         withBackground:(NCColor *)background
         withForeground:(NCColor *)foreground
                atIndex:(NSUInteger)index
{
    chars.insert(chars.begin(), c + foreground.color * 1000 + background.color * 10000);
}

- (void)deleteCharacterAtIndex:(NSUInteger)index
{
    if(index < chars.size()) {
        chars.erase(chars.begin() + index);
    } else if(chars.size() > 0) {
        chars.erase(chars.end());
    }
}

@end
