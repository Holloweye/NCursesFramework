//
//  NCGraphic+Bounds.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 22/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCPlatform.h"
#import "NCRendition.h"

@interface NCGraphic (Bounds)

- (CGRect)padding;

- (CGSize)sizeRespectingMinMaxValuesForBounds:(CGSize)myBounds
                              forParentBounds:(CGSize)parentBounds;

- (CGSize)sizeAppendingPaddingForBounds:(CGSize)myBounds
                        forParentBounds:(CGSize)parentBounds;

- (NCRendition *)applyPaddingOnRendition:(NCRendition*)rendition
                            withPlatform:(NCPlatform*)platform;

@end
