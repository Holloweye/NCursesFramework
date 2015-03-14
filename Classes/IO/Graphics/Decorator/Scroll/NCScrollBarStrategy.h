//
//  NCScrollBarStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCCursesRendition;

@interface NCScrollBarStrategy : NSObject

- (NCCursesRendition*)drawInBounds:(CGSize)bounds
                               pos:(int)pos
                               max:(int)max;

@end
