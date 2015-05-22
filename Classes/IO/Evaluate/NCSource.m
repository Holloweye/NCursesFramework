//
//  NCSource.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCSource.h"

@interface NCSource ()
@property (nonatomic, strong) NSMutableString *string;

@property (nonatomic, assign) int characterPosition;
@property (nonatomic, assign) char currentCharacter;
@property (nonatomic, assign) char peekCharacter;
@end

@implementation NCSource

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if(self) {
        self.characterPosition = -2;
        self.string = [NSMutableString stringWithString:string];
    }
    return self;
}

- (char) currentChar
{
    if(self.characterPosition == -2) {
        return [self nextChar];
    } else {
        if(self.currentCharacter == 0) {
            return EOF;
        } else {
            return self.currentCharacter;
        }
    }
}

- (char) nextChar
{
    [self readChar];
    self.characterPosition++;
    return self.currentCharacter;
}

- (char) peekChar
{
    return self.peekCharacter;
}

- (int) getCharacterPosition
{
    return self.characterPosition;
}

- (void)readChar
{
    if(self.string) {
        if(self.characterPosition == -2) {
            self.currentCharacter = (self.string.length > 0 ? [self.string characterAtIndex:0] : EOF);
            if(self.string.length > 0) {
                [self.string deleteCharactersInRange:NSMakeRange(0, 1)];
            }
            self.peekCharacter = (self.string.length > 0 ? [self.string characterAtIndex:0] : EOF);
            if(self.string.length > 0) {
                [self.string deleteCharactersInRange:NSMakeRange(0, 1)];
            }
            self.characterPosition = -1;
        } else {
            self.currentCharacter = self.peekCharacter;
            self.peekCharacter = (self.string.length > 0 ? [self.string characterAtIndex:0] : EOF);
            if(self.string.length > 0) {
                [self.string deleteCharactersInRange:NSMakeRange(0, 1)];
            }
        }
    }
}

@end
