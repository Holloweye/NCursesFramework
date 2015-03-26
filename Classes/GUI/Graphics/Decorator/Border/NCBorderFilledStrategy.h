//
//  NCBorderFilledStrategy.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCBorderStrategy.h"
@class NCColor;

@interface NCBorderFilledStrategy : NCBorderStrategy

- (id)initWithCornerNW:(char)nw
          withCornerNE:(char)ne
          withCornerSW:(char)sw
          withCornerSE:(char)se
                 withN:(char)n
                 withE:(char)e
                 withS:(char)s
                 withW:(char)w
         withBackground:(NCColor*)background
         withForeground:(NCColor*)foreground;

@end
