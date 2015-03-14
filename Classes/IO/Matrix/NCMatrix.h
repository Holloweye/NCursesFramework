//
//  NCMatrix.h
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCMatrix : NSObject

@property (nonatomic, assign, readonly) CGSize size;

- (id)initWithSize:(CGSize)size;

- (void)setObject:(id)object
            atPos:(CGSize)pos;

- (id)objectAtPos:(CGSize)pos;

@end
