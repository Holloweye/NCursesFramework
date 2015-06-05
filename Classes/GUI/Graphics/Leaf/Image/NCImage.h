//
//  NCImage.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 04/06/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCColor.h"
#import <AppKit/AppKit.h>

@interface NCImage : NCGraphic

@property (nonatomic, strong) NCColor *background;
@property (nonatomic, strong) NSImage *image;

@end
