//
//  NCTokenizer.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCToken.h"
#import "NCSource.h"

@interface NCTokenizer : NSObject

- (id)initWithSource:(NCSource*)source;
- (NCToken*)nextToken;

@end
