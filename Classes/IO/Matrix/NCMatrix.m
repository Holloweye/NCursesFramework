//
//  NCMatrix.m
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCMatrix.h"

@interface NCMatrix ()
{
    NSMutableArray *_cols;
}
@end

@implementation NCMatrix

- (id)initWithSize:(CGSize)size
{
    self = [super init];
    if(self) {
        _size = size;
        _cols = [NSMutableArray arrayWithCapacity:size.width];
        for(NSUInteger x = 0; x < size.width; x++) {
            NSMutableArray *rows = [NSMutableArray arrayWithCapacity:size.height];
            [_cols addObject:rows];
            for(NSUInteger y = 0; y < size.height; y++) {
                [rows addObject:[NSNull null]];
            }
        }
    }
    return self;
}

- (void)setObject:(id)object
            atPos:(CGSize)pos
{
    if(pos.width >= 0 && pos.width < _cols.count) {
        NSMutableArray *rows = [_cols objectAtIndex:pos.width];
        if(pos.height >= 0 && pos.height < rows.count) {
            [rows replaceObjectAtIndex:pos.height withObject:object];
        }
    }
}

- (id)objectAtPos:(CGSize)pos
{
    id obj = nil;
    if(pos.width >= 0 && pos.width < _cols.count) {
        NSMutableArray *rows = [_cols objectAtIndex:pos.width];
        if(pos.height >= 0 && pos.height < rows.count) {
            obj = [rows objectAtIndex:pos.height];
        }
    }
    return obj;
}

@end
