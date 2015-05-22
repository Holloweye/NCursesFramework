//
//  NCEvaluate.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCEvaluate : NSObject

+ (int)evaluate:(NSString*)string
      variables:(NSDictionary*)variables;

@end
