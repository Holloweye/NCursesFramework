//
//  NCMutableString.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCString.h"

@interface NCMutableString : NCString

- (void)addCharacter:(char)c
      withBackground:(NCColor*)background
      withForeground:(NCColor*)foreground;

- (void)insertCharacters:(const char *)str
          withBackground:(NCColor *)background
          withForeground:(NCColor *)foreground
                 atIndex:(NSUInteger)index;

- (BOOL)deleteCharacterAtIndex:(NSUInteger)index
                         count:(NSUInteger)count;

@end
