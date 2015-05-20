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

@interface NCLinearLayout : NCCanvas

- (id)initWithOrientation:(NCLinearLayoutOrientation)orientation;
@property (nonatomic, assign) NCLinearLayoutOrientation orientation;

@end
