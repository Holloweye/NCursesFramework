//
//  Logger.h
//  NCursesLibrary
//
//  Created by Christer on 2014-06-15.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+ (void) log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

@end
