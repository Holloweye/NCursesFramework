//
//  NCKey.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-13.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "NCKey.h"

@interface NCKey ()
@property (nonatomic, assign) char c;
@end

@implementation NCKey

static NSMutableArray *allKeys = nil;

+ (void)initialize
{    
    allKeys = [NSMutableArray array];

    [allKeys addObject:[self NCKEY_a]];
    [allKeys addObject:[self NCKEY_b]];
    [allKeys addObject:[self NCKEY_c]];
    [allKeys addObject:[self NCKEY_d]];
    [allKeys addObject:[self NCKEY_e]];
    [allKeys addObject:[self NCKEY_f]];
    [allKeys addObject:[self NCKEY_g]];
    [allKeys addObject:[self NCKEY_h]];
    [allKeys addObject:[self NCKEY_i]];
    [allKeys addObject:[self NCKEY_j]];
    [allKeys addObject:[self NCKEY_k]];
    [allKeys addObject:[self NCKEY_l]];
    [allKeys addObject:[self NCKEY_m]];
    [allKeys addObject:[self NCKEY_n]];
    [allKeys addObject:[self NCKEY_o]];
    [allKeys addObject:[self NCKEY_p]];
    [allKeys addObject:[self NCKEY_q]];
    [allKeys addObject:[self NCKEY_r]];
    [allKeys addObject:[self NCKEY_s]];
    [allKeys addObject:[self NCKEY_t]];
    [allKeys addObject:[self NCKEY_u]];
    [allKeys addObject:[self NCKEY_v]];
    [allKeys addObject:[self NCKEY_w]];
    [allKeys addObject:[self NCKEY_x]];
    [allKeys addObject:[self NCKEY_y]];
    
    [allKeys addObject:[self NCKEY_A]];
    [allKeys addObject:[self NCKEY_B]];
    [allKeys addObject:[self NCKEY_C]];
    [allKeys addObject:[self NCKEY_D]];
    [allKeys addObject:[self NCKEY_E]];
    [allKeys addObject:[self NCKEY_F]];
    [allKeys addObject:[self NCKEY_G]];
    [allKeys addObject:[self NCKEY_H]];
    [allKeys addObject:[self NCKEY_I]];
    [allKeys addObject:[self NCKEY_J]];
    [allKeys addObject:[self NCKEY_K]];
    [allKeys addObject:[self NCKEY_L]];
    [allKeys addObject:[self NCKEY_M]];
    [allKeys addObject:[self NCKEY_N]];
    [allKeys addObject:[self NCKEY_O]];
    [allKeys addObject:[self NCKEY_P]];
    [allKeys addObject:[self NCKEY_Q]];
    [allKeys addObject:[self NCKEY_R]];
    [allKeys addObject:[self NCKEY_S]];
    [allKeys addObject:[self NCKEY_T]];
    [allKeys addObject:[self NCKEY_U]];
    [allKeys addObject:[self NCKEY_V]];
    [allKeys addObject:[self NCKEY_W]];
    [allKeys addObject:[self NCKEY_X]];
    [allKeys addObject:[self NCKEY_Y]];
    
    [allKeys addObject:[self NCKEY_ENTER]];
    [allKeys addObject:[self NCKEY_BACK_SPACE]];
    [allKeys addObject:[self NCKEY_BLANK_SPACE]];
    
    [allKeys addObject:[self NCKEY_ESC]];
    [allKeys addObject:[self NCKEY_ARROW_UP]];
    [allKeys addObject:[self NCKEY_ARROW_DOWN]];
    [allKeys addObject:[self NCKEY_ARROW_LEFT]];
    [allKeys addObject:[self NCKEY_ARROW_RIGHT]];
}

- (id) initWithChar:(char)c
{
    self = [super init];
    if(self) {
        self.c = c;
    }
    return self;
}

- (char)getCharacter
{
    return self.c;
}

+ (NCKey *) NCKEY_a
{
    return [[NCKey alloc] initWithChar:'a'];
}

+ (NCKey *) NCKEY_b
{
    return [[NCKey alloc] initWithChar:'b'];
}

+ (NCKey *) NCKEY_c
{
    return [[NCKey alloc] initWithChar:'c'];
}

+ (NCKey *) NCKEY_d
{
    return [[NCKey alloc] initWithChar:'d'];
}

+ (NCKey *) NCKEY_e
{
    return [[NCKey alloc] initWithChar:'e'];
}

+ (NCKey *) NCKEY_f
{
    return [[NCKey alloc] initWithChar:'f'];
}

+ (NCKey *) NCKEY_g
{
    return [[NCKey alloc] initWithChar:'g'];
}

+ (NCKey *) NCKEY_h
{
    return [[NCKey alloc] initWithChar:'h'];
}

+ (NCKey *) NCKEY_i
{
    return [[NCKey alloc] initWithChar:'i'];
}

+ (NCKey *) NCKEY_j
{
    return [[NCKey alloc] initWithChar:'j'];
}

+ (NCKey *) NCKEY_k
{
    return [[NCKey alloc] initWithChar:'k'];
}

+ (NCKey *) NCKEY_l
{
    return [[NCKey alloc] initWithChar:'l'];
}

+ (NCKey *) NCKEY_m
{
    return [[NCKey alloc] initWithChar:'m'];
}

+ (NCKey *) NCKEY_n
{
    return [[NCKey alloc] initWithChar:'n'];
}

+ (NCKey *) NCKEY_o
{
    return [[NCKey alloc] initWithChar:'o'];
}

+ (NCKey *) NCKEY_p
{
    return [[NCKey alloc] initWithChar:'p'];
}

+ (NCKey *) NCKEY_q
{
    return [[NCKey alloc] initWithChar:'q'];
}

+ (NCKey *) NCKEY_r
{
    return [[NCKey alloc] initWithChar:'r'];
}

+ (NCKey *) NCKEY_s
{
    return [[NCKey alloc] initWithChar:'s'];
}

+ (NCKey *) NCKEY_t
{
    return [[NCKey alloc] initWithChar:'t'];
}

+ (NCKey *) NCKEY_u
{
    return [[NCKey alloc] initWithChar:'u'];
}

+ (NCKey *) NCKEY_v
{
    return [[NCKey alloc] initWithChar:'v'];
}

+ (NCKey *) NCKEY_w
{
    return [[NCKey alloc] initWithChar:'w'];
}

+ (NCKey *) NCKEY_x
{
    return [[NCKey alloc] initWithChar:'x'];
}

+ (NCKey *) NCKEY_y
{
    return [[NCKey alloc] initWithChar:'y'];
}

+ (NCKey *) NCKEY_z
{
    return [[NCKey alloc] initWithChar:'z'];
}

+ (NCKey *) NCKEY_A
{
    return [[NCKey alloc] initWithChar:'A'];
}

+ (NCKey *) NCKEY_B
{
    return [[NCKey alloc] initWithChar:'B'];
}

+ (NCKey *) NCKEY_C
{
    return [[NCKey alloc] initWithChar:'C'];
}

+ (NCKey *) NCKEY_D
{
    return [[NCKey alloc] initWithChar:'D'];
}

+ (NCKey *) NCKEY_E
{
    return [[NCKey alloc] initWithChar:'E'];
}

+ (NCKey *) NCKEY_F
{
    return [[NCKey alloc] initWithChar:'F'];
}

+ (NCKey *) NCKEY_G
{
    return [[NCKey alloc] initWithChar:'G'];
}

+ (NCKey *) NCKEY_H
{
    return [[NCKey alloc] initWithChar:'H'];
}

+ (NCKey *) NCKEY_I
{
    return [[NCKey alloc] initWithChar:'I'];
}

+ (NCKey *) NCKEY_J
{
    return [[NCKey alloc] initWithChar:'J'];
}

+ (NCKey *) NCKEY_K
{
    return [[NCKey alloc] initWithChar:'K'];
}

+ (NCKey *) NCKEY_L
{
    return [[NCKey alloc] initWithChar:'L'];
}

+ (NCKey *) NCKEY_M
{
    return [[NCKey alloc] initWithChar:'M'];
}

+ (NCKey *) NCKEY_N
{
    return [[NCKey alloc] initWithChar:'N'];
}

+ (NCKey *) NCKEY_O
{
    return [[NCKey alloc] initWithChar:'O'];
}

+ (NCKey *) NCKEY_P
{
    return [[NCKey alloc] initWithChar:'P'];
}

+ (NCKey *) NCKEY_Q
{
    return [[NCKey alloc] initWithChar:'Q'];
}

+ (NCKey *) NCKEY_R
{
    return [[NCKey alloc] initWithChar:'R'];
}

+ (NCKey *) NCKEY_S
{
    return [[NCKey alloc] initWithChar:'S'];
}

+ (NCKey *) NCKEY_T
{
    return [[NCKey alloc] initWithChar:'T'];
}

+ (NCKey *) NCKEY_U
{
    return [[NCKey alloc] initWithChar:'U'];
}

+ (NCKey *) NCKEY_V
{
    return [[NCKey alloc] initWithChar:'V'];
}

+ (NCKey *) NCKEY_W
{
    return [[NCKey alloc] initWithChar:'W'];
}

+ (NCKey *) NCKEY_X
{
    return [[NCKey alloc] initWithChar:'X'];
}

+ (NCKey *) NCKEY_Y
{
    return [[NCKey alloc] initWithChar:'Y'];
}

+ (NCKey *) NCKEY_Z
{
    return [[NCKey alloc] initWithChar:'Z'];
}

+ (NCKey *) NCKEY_ENTER
{
    return [[NCKey alloc] initWithChar:(char)10];
}

+ (NCKey *) NCKEY_ESC
{
    return [[NCKey alloc] initWithChar:(char)27];
}

+ (NCKey *) NCKEY_BACK_SPACE
{
    return [[NCKey alloc] initWithChar:(char)127];
}

+ (NCKey *) NCKEY_BLANK_SPACE
{
    return [[NCKey alloc] initWithChar:' '];
}

+ (NCKey *) NCKEY_ARROW_UP
{
    return [[NCKey alloc] initWithChar:(char)3];
}

+ (NCKey *) NCKEY_ARROW_DOWN
{
    return [[NCKey alloc] initWithChar:(char)2];
}

+ (NCKey *) NCKEY_ARROW_LEFT
{
    return [[NCKey alloc] initWithChar:(char)4];
}

+ (NCKey *) NCKEY_ARROW_RIGHT
{
    return [[NCKey alloc] initWithChar:(char)5];
}

- (BOOL) isChar:(char)c
{
    return (self.c == c);
}

+ (NCKey *)getKeyFromChar:(char)c
{
    for(NCKey *key in allKeys) {
        if([key isChar:c]) {
            return key;
        }
    }
    return [[NCKey alloc] initWithChar:c];
}

- (BOOL)isEqual:(NCKey*)object
{
    if(object && [object isKindOfClass:[NCKey class]]) {
        return self.c == object.c;
    }
    return NO;
}

@end
