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

typedef enum : NSUInteger {
    NCGravityTopLeft,
    NCGravityTopCenter,
    NCGravityTopRight,
    
    NCGravityMiddleLeft,
    NCGravityMiddleCenter,
    NCGravityMiddleRight,
    
    NCGravityBottomLeft,
    NCGravityBottomCenter,
    NCGravityBottomRight,
} NCGravity;

/*
 XML keys availiable:
 
 "id" = sid
 "gravity" = gravity
 "minSize" = minSize
 
 */
@interface NCGraphic : NSObject

/*
 Identifier name for this graphic, used to later retrieve it with [graphic findGraphicWithId:].
 */
@property (nonatomic, strong) NSString *sid;

/*
 Positioning of graphic within a potentially larger container.
 */
@property (nonatomic, assign) NCGravity gravity;

/*
 Defines the minimum height of the graphic. It is not guaranteed the graphic will be able to achieve this minimum size (for example, if its parent's size is less minimum size).
 
 Dynamic keys availiable to use:
 parentHeight
 parentWidth
 */
@property (nonatomic, strong) NSString *minWidth;
@property (nonatomic, strong) NSString *minHeight;

@property (nonatomic, strong) NSString *maxWidth;
@property (nonatomic, strong) NSString *maxHeight;

- (id)initWithAttributes:(NSDictionary*)attributes;

- (NCRendition*)drawInBounds:(CGSize)bounds
                withPlatform:(NCPlatform*)platform;

- (CGSize)sizeWithinBounds:(CGSize)bounds;

- (NCGraphic*)findGraphicWithId:(NSString*)sid;

- (NCCanvas*)getCanvas;
- (void)addChild:(NCGraphic*)child;
- (void)removeChild:(NCGraphic*)child;

@end
