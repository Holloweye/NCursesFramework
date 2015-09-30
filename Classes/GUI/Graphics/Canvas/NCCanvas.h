//
//  NCCanvas.h
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"

/*
 A generic container, inherit from this class to create a new type of container graphic.
 */
@interface NCCanvas : NCGraphic
@property (nonatomic, strong, readonly) NSMutableArray *children;
@end
