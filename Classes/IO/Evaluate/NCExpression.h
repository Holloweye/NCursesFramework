//
//  NCExpression.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 22/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCTokenizer.h"

@interface NCExpression : NSObject

- (id)initWithTokenizer:(NCTokenizer*)tokenizer;
- (int)evalWithWords:(NSDictionary*)words;

@property (nonatomic, strong) NSMutableArray *tokens;

@end
