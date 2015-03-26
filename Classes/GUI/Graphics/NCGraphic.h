//
//  NCGraphic.h
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCRendition;
@class NCCanvas;
@class NCPlatform;

@interface NCGraphic : NSObject

- (NCRendition*)drawInBounds:(CGSize)bounds
                withPlatform:(NCPlatform*)platform;
- (CGSize)sizeWithinBounds:(CGSize)bounds;

- (NCCanvas*)getCanvas;
- (void)addChild:(NCGraphic*)child;
- (void)removeChild:(NCGraphic*)child;

@end
