//
//  NCBorderStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCCursesRendition;

typedef enum : NSUInteger {
    NCBorderPositionTop,
    NCBorderPositionLeft,
    NCBorderPositionBottom,
    NCBorderPositionRight
} NCBorderPosition;

@interface NCBorderStrategy : NSObject

- (NCCursesRendition*)drawInBounds:(CGSize)bounds
                          position:(NCBorderPosition)position;

@end
