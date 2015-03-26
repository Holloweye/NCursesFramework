//
//  NCScrollBarStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCRendition;
@class NCPlatform;

@interface NCScrollBarStrategy : NSObject

- (NCRendition*)drawInBounds:(CGSize)bounds
                withPlatform:(NCPlatform *)platform
                         pos:(int)pos
                         max:(int)max;

@end
