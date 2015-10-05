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

- (void)insertCharacters:(const char *)str
          withBackground:(NCColor *)background
          withForeground:(NCColor *)foreground
                 atIndex:(NSUInteger)index
{
    for(int i = 0; i < strlen(str); i++) {
        chars.insert(chars.begin() + index, str[i] + foreground.color * 1000 + background.color * 10000);
        index++;
    }
}

- (BOOL)deleteCharacterAtIndex:(NSUInteger)index
                         count:(NSUInteger)count
{
    if(index < self.length) {
        if(index + count > self.length) {
            count = self.length - index;
        }
        if(count > 0) {
            if(index + count <= chars.size()) {
                chars.erase(chars.begin() + index, chars.begin() + index + count);
                return YES;
            }
        }
    }
    return NO;
}

@end
