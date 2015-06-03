//
//  NCRendition.h
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCColor.h"
@class NCRender;

@interface NCRendition : NSObject

- (id)initWithBounds:(CGSize)bounds;

- (CGSize)bounds;

- (void)setCharacter:(char)c
                  at:(CGSize)pos
      withForeground:(Color)foreground
      withBackground:(Color)background;

- (void)mergeRendition:(NCRendition*)rendition
               inFrame:(CGRect)frame;

- (void)drawToScreen;

+ (CGSize)screenSize;

@end
