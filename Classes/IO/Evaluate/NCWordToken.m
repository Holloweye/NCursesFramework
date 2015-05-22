//
//  NCVariableToken.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCWordToken.h"

@implementation NCWordToken

- (void)extract
{
    char currentChar = [self.source currentChar];
    
    NSMutableString *textBuffer = [NSMutableString string];
    
    while(isalpha(currentChar) || isnumber(currentChar)) {
        [textBuffer appendFormat:@"%c",currentChar];
        currentChar = [self.source nextChar];
    }
    
    self.text = textBuffer;
}

@end
