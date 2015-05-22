//
//  NCGraphic+Bounds.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 22/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"

@interface NCGraphic (Bounds)

- (CGSize)sizeRespectingMinMaxValuesForBounds:(CGSize)myBounds
                              forParentBounds:(CGSize)parentBounds;

@end
