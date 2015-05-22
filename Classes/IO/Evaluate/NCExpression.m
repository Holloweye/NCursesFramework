//
//  NCExpression.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 22/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCExpression.h"
#import "NCNumberToken.h"
#import "NCWordToken.h"

@implementation NCExpression

- (id)initWithTokenizer:(NCTokenizer*)tokenizer
{
    self = [super init];
    if(self) {
        self.tokens = [NSMutableArray array];
        
        NCToken *token = [tokenizer nextToken];
        while(token) {
            
            if([token.text isEqualToString:@"("]) {
                NCExpression *expression = [[NCExpression alloc] initWithTokenizer:tokenizer];
                [self.tokens addObject:expression];
            } else if([token.text isEqualToString:@")"]) {
                break;
            } else {
                [self.tokens addObject:token];
            }
            token = [tokenizer nextToken];
        }
    }
    return self;
}

- (int)evalWithWords:(NSDictionary *)words
{
    NSMutableArray *mTokens = [NSMutableArray arrayWithArray:self.tokens];
    
    // * or /
    NSArray *signOrder = @[ @[@"*", @"/"], @[@"+", @"-"] ];
    
    for(NSArray *signs in signOrder) {
        NCToken *signToken;
        do {
            signToken = nil;
            
            NSUInteger index = NSNotFound;
            for(NSUInteger i = mTokens.count-1; i < mTokens.count && index == NSNotFound; i--) {
                NCToken *token = [mTokens objectAtIndex:i];
                if([token isKindOfClass:[NCToken class]] && [signs containsObject:token.text]) {
                    index = i;
                    signToken = token;
                }
            }
            
            if(signToken) {
                
                NCToken *left = (index-1 < mTokens.count ? [mTokens objectAtIndex:index-1] : nil);
                NCToken *right = (index+1 < mTokens.count ? [mTokens objectAtIndex:index+1] : nil);
                
                int leftVal = 0;
                if([left isKindOfClass:[NCExpression class]]) {
                    leftVal = [((NCExpression*)left) evalWithWords:words];
                } else if([left isKindOfClass:[NCWordToken class]]) {
                    NSNumber *nr = [words objectForKey:left.text];
                    if(nr) {
                        leftVal = [nr intValue];
                    }
                } else {
                    leftVal = left.value;
                }
                
                int rightVal = 0;
                if([right isKindOfClass:[NCExpression class]]) {
                    rightVal = [((NCExpression*)right) evalWithWords:words];
                } else if([right isKindOfClass:[NCWordToken class]]) {
                    NSNumber *nr = [words objectForKey:right.text];
                    if(nr) {
                        rightVal = [nr intValue];
                    }
                } else {
                    rightVal = right.value;
                }
                
                // Create a new number token at the position of the left most of these tokens.
                int result = 0;
                if([signToken.text isEqualToString:@"*"]) {
                    result = leftVal * rightVal;
                } else if([signToken.text isEqualToString:@"/"]) {
                    result = leftVal / rightVal;
                } else if([signToken.text isEqualToString:@"+"]) {
                    result = leftVal + rightVal;
                } else if([signToken.text isEqualToString:@"-"]) {
                    result = leftVal - rightVal;
                }
                
                NCNumberToken *resultToken = [[NCNumberToken alloc] init];
                resultToken.value = result;
                if(left) {
                    [mTokens insertObject:resultToken
                                  atIndex:[mTokens indexOfObject:left]];
                } else if(signToken) {
                    [mTokens insertObject:resultToken
                                  atIndex:[mTokens indexOfObject:signToken]];
                } else if(right) {
                    [mTokens insertObject:resultToken
                                  atIndex:[mTokens indexOfObject:right]];
                }
                
                [mTokens removeObject:left];
                [mTokens removeObject:signToken];
                [mTokens removeObject:right];
            }
        } while (signToken);
    }
    
    // Take the last remaining token / Expressen and takes its value and return it.
    NCToken *token = [mTokens firstObject];
    if([token isKindOfClass:[NCWordToken class]]) {
        NSNumber *nr = [words objectForKey:token.text];
        if(nr) {
            return [nr intValue];
        }
    }
    return token ? token.value : 0;
}

@end
