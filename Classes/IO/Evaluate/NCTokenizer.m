//
//  NCTokenizer.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCTokenizer.h"
#import "NCSignToken.h"
#import "NCNumberToken.h"
#import "NCWordToken.h"

@interface NCTokenizer ()
@property (nonatomic, assign) int pos;
@property (nonatomic, strong) NCSource *source;
@end

@implementation NCTokenizer

- (id)initWithSource:(NCSource *)source
{
    self = [super init];
    if(self) {
        self.source = source;
    }
    return self;
}

- (NCToken *)nextToken
{
    [self skipWhiteSpace];
    
    NCToken *token = nil;
    char currentChar = [self currentChar];
    
    if(isalpha(currentChar)) {
        token = [[NCWordToken alloc] initWithSource:self.source];
    } else if(isnumber(currentChar)) {
        token = [[NCNumberToken alloc] initWithSource:self.source];
    } else if(currentChar == '+' ||
              currentChar == '-' ||
              currentChar == '*' ||
              currentChar == '/' ||
              currentChar == '(' ||
              currentChar == ')') {
        token = [[NCSignToken alloc] initWithSource:self.source];
    }
    
    return token;
}

- (void) skipWhiteSpace
{
    char currentChar = [self currentChar];
    
    while (currentChar == ' ') {
        currentChar = [self nextChar];
    }
}

- (char) currentChar
{
    return [self.source currentChar];
}

- (char) nextChar
{
    return [self.source nextChar];
}

@end
