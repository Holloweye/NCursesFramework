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
 Defines the minimum size of the graphic. It is not guaranteed the graphic will be able to achieve this minimum size (for example, if its parent's size is less minimum size).
 
 Dynamic keys availiable to use:
 parentHeight
 parentWidth
 */
@property (nonatomic, strong) NSString *minWidth;
@property (nonatomic, strong) NSString *minHeight;

/*
 Defines the maximum size of the graphic.
 
 Dynamic keys availiable to use:
 parentHeight
 parentWidth
 */
@property (nonatomic, strong) NSString *maxWidth;
@property (nonatomic, strong) NSString *maxHeight;

/*
 Padding is defined as space between the edges of the graphic and the graphic's content. A graphic's size will include it's padding.
 */
@property (nonatomic, strong) NSString *topPadding;
@property (nonatomic, strong) NSString *rightPadding;
@property (nonatomic, strong) NSString *bottomPadding;
@property (nonatomic, strong) NSString *leftPadding;

/*
 Constructor that is called when inflating a graphic from XML.
 */
- (id)initWithAttributes:(NSDictionary*)attributes;

/*
 Renders this graphic (and all of its children) for the given platform and bounds.
 */
- (NCRendition*)drawInBounds:(CGSize)bounds
                withPlatform:(NCPlatform*)platform;

/*
 Measures the graphic and its content to determine the width and the height.
 */
- (CGSize)sizeWithinBounds:(CGSize)bounds;

/*
 Look for a child graphic with the given id. If this graphic has the given id, this graphic is returned.
 */
- (NCGraphic*)findGraphicWithId:(NSString*)sid;

/*
 
 */
- (NCCanvas*)getCanvas;
- (void)addChild:(NCGraphic*)child;
- (void)insertChild:(NCGraphic*)child atIndex:(NSUInteger)index;
- (void)removeChild:(NCGraphic*)child;
- (void)removeAllChildren;

@end
