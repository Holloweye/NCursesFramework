//
//  NCEvaluate.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCEvaluate.h"
#import "NCSource.h"
#import "NCTokenizer.h"
#import "NCExpression.h"

@implementation NCEvaluate

+ (int)evaluate:(NSString *)string
      variables:(NSDictionary *)variables
{
    NCSource *source = [[NCSource alloc] initWithString:string];
    NCTokenizer *tokenizer = [[NCTokenizer alloc] initWithSource:source];
    NCExpression *expression = [[NCExpression alloc] initWithTokenizer:tokenizer];
    return [expression evalWithWords:variables];
}

@end
