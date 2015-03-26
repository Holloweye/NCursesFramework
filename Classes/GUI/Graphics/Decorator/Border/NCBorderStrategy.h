//
//  NCBorderStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCRendition;
@class NCPlatform;

typedef enum : NSUInteger {
    NCBorderPositionTop,
    NCBorderPositionLeft,
    NCBorderPositionBottom,
    NCBorderPositionRight
} NCBorderPosition;

@interface NCBorderStrategy : NSObject

- (NCRendition*)drawInBounds:(CGSize)bounds
                withPlatform:(NCPlatform *)platform
                    position:(NCBorderPosition)position;

@end
