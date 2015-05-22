//
//  NCConstantToken.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCNumberToken.h"

@implementation NCNumberToken

- (void)extract
{
    self.value = [self computeIntegerValue:[self extractUnsignedIntegerDigits]];
}

- (int) computeIntegerValue:(NSString*)digits
{
    if(digits == nil) {
        return 0;
    }
    
    int integerValue = 0;
    int prevValue = -1;
    int index = 0;
    
    while ((index < digits.length) && integerValue >= prevValue) {
        prevValue = integerValue;
        integerValue = 10 * integerValue + ([digits characterAtIndex:index++] - '0');
    }
    
    if(integerValue >= prevValue) {
        return integerValue;
    } else {
        return 0;
    }
}

- (NSString *) extractUnsignedIntegerDigits
{
    char currentChar = [self.source currentChar];
    
    if(!isnumber(currentChar)) {
        return nil;
    }
    
    NSMutableString *digits = [NSMutableString string];
    while (isnumber(currentChar)) {
        [digits appendFormat:@"%c",currentChar];
        currentChar = [self.source nextChar];
    }
    
    return digits;
}

@end
