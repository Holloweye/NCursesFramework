//
//  NCDecorator.h
//  NCursesF
//
//  Created by Christer on 2015-03-12.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"

@interface NCDecorator : NCGraphic

- (id)initWithGraphic:(NCGraphic*)graphic;

@property (nonatomic, strong, readonly) NCGraphic *graphic;

@end
