//
//  NCScrollDecorator.h
//  NCursesF
//
//  Created by Christer on 2015-03-13.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDecorator.h"
@class NCScrollBarStrategy;
@class NCColor;

typedef enum : NSUInteger {
    NCScrollOrientationHorizontal,
    NCScrollOrientationVertical
} NCScrollOrientation;

@interface NCScrollDecorator : NCDecorator

@property (nonatomic, strong) NCColor *background;
@property (nonatomic, strong) NCScrollBarStrategy *strategy;
@property (nonatomic, assign) CGSize offset;
@property (nonatomic, assign) NCScrollOrientation orientation;

@end
