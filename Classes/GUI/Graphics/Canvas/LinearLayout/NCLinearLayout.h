//
//  NCLinearLayout.h
//  NCursesFramework
//
//  Created by Christer on 2015-03-26.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCCanvas.h"

typedef enum : NSUInteger {
    NCLinearLayoutOrientationVertical,
    NCLinearLayoutOrientationHorizontal,
} NCLinearLayoutOrientation;

/*
 A NCLinearLayout is a container graphic that arranges its children in a single column or a single row.
 */
@interface NCLinearLayout : NCCanvas
/*
 XML keys availiable:
 
 "orientation" = "vertical" / "horizontal"
 */

- (id)initWithOrientation:(NCLinearLayoutOrientation)orientation;

/*
 Orientation of which the children should be layed out. The default orientation is vertical.
 */
@property (nonatomic, assign) NCLinearLayoutOrientation orientation;

@end
