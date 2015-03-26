//
//  NCScrollBarSimpleStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCScrollBarStrategy.h"
@class NCColor;

@interface NCScrollBarSimpleStrategy : NCScrollBarStrategy

- (id)initWithForeground:(NCColor*)foreground
          withBackground:(NCColor*)background;

@end
