//
//  NCDummyRendition.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 20/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDummyRendition.h"

@implementation NCDummyRendition

- (void)drawToScreen
{
    // Dummy
}

+ (CGSize)screenSize
{
    return CGSizeMake(100, 40);
}

@end
