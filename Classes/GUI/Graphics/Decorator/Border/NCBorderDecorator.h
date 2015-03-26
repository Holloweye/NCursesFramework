//
//  NCBorderDecorator.h
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDecorator.h"
@class NCBorderStrategy;

@interface NCBorderDecorator : NCDecorator

@property (nonatomic, strong) NCBorderStrategy *strategy;

@end
