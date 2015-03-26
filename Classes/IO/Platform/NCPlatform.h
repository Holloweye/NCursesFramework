//
//  NCPlatform.h
//  NCursesFramework
//
//  Created by Christer on 2015-03-26.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCRendition;
@class NCKey;

@interface NCPlatform : NSObject

- (NCRendition *)createRenditionWithBounds:(CGSize)bounds;
- (NCKey*) getKey;
- (CGSize)screenSize;

@end
