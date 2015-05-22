//
//  NCToken.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCToken.h"

@implementation NCToken

- (id)initWithSource:(NCSource*)source
{
    self = [super init];
    if(self) {
        self.source = source;
        self.position = [source getCharacterPosition];
        [self extract];
    }
    return self;
}

- (void)extract
{
    _text = [NSString stringWithFormat:@"%c",[self.source currentChar]];
    
    [self.source nextChar]; // consume current character
}

@end
