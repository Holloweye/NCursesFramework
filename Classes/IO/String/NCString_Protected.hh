//
//  NCString_Protected.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "vector"

@interface NCString ()
{
    @protected
    std::vector<int> chars;
}

- (id)initWithVector:(std::vector<int>)vector;

@end
