//
//  NCToken.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCSource.h"

@interface NCToken : NSObject

- (id)initWithSource:(NCSource*)source;
- (void)extract;

@property (nonatomic, strong) NCSource *source;
@property (nonatomic, assign) int position;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) int value;

@end
