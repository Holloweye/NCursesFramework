//
//  NCSpacer.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 25/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCColor.h"

@interface NCSpacer : NCGraphic

@property (nonatomic, strong) NCColor *background;
@property (nonatomic, strong) NCColor *foreground;
@property (nonatomic, assign) char character;

@end
