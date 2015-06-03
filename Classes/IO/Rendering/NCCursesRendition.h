//
//  NCCursesRendition.h
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCRendition.h"

@interface NCCursesRendition : NCRendition

- (int)fgForPos:(CGSize)pos;
- (int)bgForPos:(CGSize)pos;
- (char)charForPos:(CGSize)pos;

@end
