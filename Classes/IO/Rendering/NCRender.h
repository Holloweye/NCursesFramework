//
//  NCRender.h
//  NCursesLibrary
//
//  Created by Christer on 2014-06-16.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCColor.h"

@interface NCRender : NSObject

- (id)initWithCharacter:(char)c
         withBackground:(NCColor*)background
         withForeground:(NCColor*)foreground;

@property (nonatomic, strong, readonly) NCColor *background;
@property (nonatomic, strong, readonly) NCColor *foreground;
@property (nonatomic, assign, readonly) char character;

@end
