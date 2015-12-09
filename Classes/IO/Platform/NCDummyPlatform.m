//
//  NCDummyPlatform.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 20/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCDummyPlatform.h"
#import "NCDummyRendition.h"
#import "NCKey.h"

@implementation NCDummyPlatform

static NCDummyPlatform *instance = nil;
+ (NCDummyPlatform *)factory
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NCDummyPlatform alloc] init];
    });
    return instance;
}

- (NCKey *)getKey
{
    char c = (char)getchar();
    return [NCKey getKeyFromChar1:c char2:-1 char3:-1 char4:-1];
}

- (NCRendition *)createRenditionWithBounds:(CGSize)bounds
{
    return [[NCDummyRendition alloc] initWithBounds:bounds];
}

- (CGSize)screenSize
{
    return [NCDummyRendition screenSize];
}

@end
