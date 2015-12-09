//
//  NCKey.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-13.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "NCKey.h"

@interface NCKey ()
@property (nonatomic, assign) char c1;
@property (nonatomic, assign) char c2;
@property (nonatomic, assign) char c3;
@property (nonatomic, assign) char c4;
@property (nonatomic, assign) char rep;
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
    
    [allKeys addObject:[self NCKEY_CTRL_A]];
    [allKeys addObject:[self NCKEY_CTRL_B]];
    [allKeys addObject:[self NCKEY_CTRL_C]];
    [allKeys addObject:[self NCKEY_CTRL_D]];
    [allKeys addObject:[self NCKEY_CTRL_E]];
    [allKeys addObject:[self NCKEY_CTRL_F]];
    [allKeys addObject:[self NCKEY_CTRL_GH]];
    [allKeys addObject:[self NCKEY_CTRL_I]];
    [allKeys addObject:[self NCKEY_CTRL_JM]];
    [allKeys addObject:[self NCKEY_CTRL_K]];
    [allKeys addObject:[self NCKEY_CTRL_L]];
    [allKeys addObject:[self NCKEY_CTRL_N]];
    [allKeys addObject:[self NCKEY_CTRL_O]];
    [allKeys addObject:[self NCKEY_CTRL_P]];
    [allKeys addObject:[self NCKEY_CTRL_Q]];
    [allKeys addObject:[self NCKEY_CTRL_R]];
    [allKeys addObject:[self NCKEY_CTRL_S]];
    [allKeys addObject:[self NCKEY_CTRL_T]];
    [allKeys addObject:[self NCKEY_CTRL_U]];
    [allKeys addObject:[self NCKEY_CTRL_V]];
    [allKeys addObject:[self NCKEY_CTRL_W]];
    [allKeys addObject:[self NCKEY_CTRL_X]];
    [allKeys addObject:[self NCKEY_CTRL_Y]];
    
    [allKeys addObject:[self NCKEY_ALT_A]];
    [allKeys addObject:[self NCKEY_ALT_B]];
    [allKeys addObject:[self NCKEY_ALT_C]];
    [allKeys addObject:[self NCKEY_ALT_D]];
    [allKeys addObject:[self NCKEY_ALT_E]];
    [allKeys addObject:[self NCKEY_ALT_F]];
    [allKeys addObject:[self NCKEY_ALT_G]];
    [allKeys addObject:[self NCKEY_ALT_H]];
    [allKeys addObject:[self NCKEY_ALT_I]];
    [allKeys addObject:[self NCKEY_ALT_J]];
    [allKeys addObject:[self NCKEY_ALT_K]];
    [allKeys addObject:[self NCKEY_ALT_L]];
    [allKeys addObject:[self NCKEY_ALT_M]];
    [allKeys addObject:[self NCKEY_ALT_N]];
    [allKeys addObject:[self NCKEY_ALT_O]];
    [allKeys addObject:[self NCKEY_ALT_P]];
    [allKeys addObject:[self NCKEY_ALT_Q]];
    [allKeys addObject:[self NCKEY_ALT_R]];
    [allKeys addObject:[self NCKEY_ALT_S]];
    [allKeys addObject:[self NCKEY_ALT_T]];
    [allKeys addObject:[self NCKEY_ALT_U]];
    [allKeys addObject:[self NCKEY_ALT_V]];
    [allKeys addObject:[self NCKEY_ALT_W]];
    [allKeys addObject:[self NCKEY_ALT_X]];
    [allKeys addObject:[self NCKEY_ALT_Y]];
    
    [allKeys addObject:[self NCKEY_ENTER]];
    [allKeys addObject:[self NCKEY_BACK_SPACE]];
    [allKeys addObject:[self NCKEY_BLANK_SPACE]];
    
    [allKeys addObject:[self NCKEY_ESC]];
    [allKeys addObject:[self NCKEY_ARROW_UP]];
    [allKeys addObject:[self NCKEY_ARROW_DOWN]];
    [allKeys addObject:[self NCKEY_ARROW_LEFT]];
    [allKeys addObject:[self NCKEY_ARROW_RIGHT]];
}

- (id) initWithChar1:(char)c1
               char2:(char)c2
               char3:(char)c3
               char4:(char)c4
      representative:(char)rep
{
    self = [super init];
    if(self) {
        self.c1 = c1;
        self.c2 = c2;
        self.c3 = c3;
        self.c4 = c4;
        self.rep = rep;
    }
    return self;
}

- (char)getCharacter
{
    return self.rep;
}

+ (NCKey *) SIMPLE:(char)c
{
    return [[NCKey alloc] initWithChar1:c char2:-1 char3:-1 char4:-1 representative:c];
}

+ (NCKey *) EVENT:(char)c
{
    return [[NCKey alloc] initWithChar1:c char2:-1 char3:-1 char4:-1 representative:-1];
}

+ (NCKey *) NCKEY_CTRL_A
{
    return [[NCKey alloc] initWithChar1:1
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'a'];
}

+ (NCKey *) NCKEY_CTRL_B
{
    return [[NCKey alloc] initWithChar1:2
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'b'];
}

+ (NCKey *) NCKEY_CTRL_C
{
    return [[NCKey alloc] initWithChar1:3
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'c'];
}

+ (NCKey *) NCKEY_CTRL_D
{
    return [[NCKey alloc] initWithChar1:4
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'d'];
}

+ (NCKey *) NCKEY_CTRL_E
{
    return [[NCKey alloc] initWithChar1:5
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'e'];
}

+ (NCKey *) NCKEY_CTRL_F
{
    return [[NCKey alloc] initWithChar1:6
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'f'];
}

+ (NCKey *) NCKEY_CTRL_GH
{
    return [[NCKey alloc] initWithChar1:7
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'f'];
}

+ (NCKey *) NCKEY_CTRL_I
{
    return [[NCKey alloc] initWithChar1:9
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'i'];
}

+ (NCKey *) NCKEY_CTRL_JM
{
    return [[NCKey alloc] initWithChar1:10
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'j'];
}

+ (NCKey *) NCKEY_CTRL_K
{
    return [[NCKey alloc] initWithChar1:11
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'k'];
}

+ (NCKey *) NCKEY_CTRL_L
{
    return [[NCKey alloc] initWithChar1:12
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'l'];
}

+ (NCKey *) NCKEY_CTRL_N
{
    return [[NCKey alloc] initWithChar1:14
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'n'];
}

+ (NCKey *) NCKEY_CTRL_O
{
    return [[NCKey alloc] initWithChar1:15
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'o'];
}

+ (NCKey *) NCKEY_CTRL_P
{
    return [[NCKey alloc] initWithChar1:16
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'p'];
}

+ (NCKey *) NCKEY_CTRL_Q
{
    return [[NCKey alloc] initWithChar1:17
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'q'];
}

+ (NCKey *) NCKEY_CTRL_R
{
    return [[NCKey alloc] initWithChar1:18
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'r'];
}

+ (NCKey *) NCKEY_CTRL_S
{
    return [[NCKey alloc] initWithChar1:19
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'s'];
}

+ (NCKey *) NCKEY_CTRL_T
{
    return [[NCKey alloc] initWithChar1:20
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'t'];
}

+ (NCKey *) NCKEY_CTRL_U
{
    return [[NCKey alloc] initWithChar1:21
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'u'];
}

+ (NCKey *) NCKEY_CTRL_V
{
    return [[NCKey alloc] initWithChar1:22
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'v'];
}

+ (NCKey *) NCKEY_CTRL_W
{
    return [[NCKey alloc] initWithChar1:23
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'w'];
}

+ (NCKey *) NCKEY_CTRL_X
{
    return [[NCKey alloc] initWithChar1:24
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'x'];
}

+ (NCKey *) NCKEY_CTRL_Y
{
    return [[NCKey alloc] initWithChar1:25
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'y'];
}

+ (NCKey *) NCKEY_CTRL_Z
{
    return [[NCKey alloc] initWithChar1:26
                                  char2:-1
                                  char3:-1
                                  char4:-1
                         representative:'z'];
}

+ (NCKey *) NCKEY_ALT_A
{
    return [[NCKey alloc] initWithChar1:-17
                                  char2:-93
                                  char3:-65
                                  char4:-1
                         representative:'a'];
}

+ (NCKey *) NCKEY_ALT_B
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-70
                                  char4:-1
                         representative:'b'];
}

+ (NCKey *) NCKEY_ALT_C
{
    return [[NCKey alloc] initWithChar1:-61
                                  char2:-89
                                  char3:-1
                                  char4:-1
                         representative:'c'];
}

+ (NCKey *) NCKEY_ALT_D
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-120
                                  char3:-126
                                  char4:-1
                         representative:'d'];
}

+ (NCKey *) NCKEY_ALT_E
{
    return [[NCKey alloc] initWithChar1:-61
                                  char2:-87
                                  char3:-1
                                  char4:-1
                         representative:'e'];
}

+ (NCKey *) NCKEY_ALT_F
{
    return [[NCKey alloc] initWithChar1:-58
                                  char2:-110
                                  char3:-1
                                  char4:-1
                         representative:'f'];
}

+ (NCKey *) NCKEY_ALT_G
{
    return [[NCKey alloc] initWithChar1:-62
                                  char2:-72
                                  char3:-1
                                  char4:-1
                         representative:'g'];
}

+ (NCKey *) NCKEY_ALT_H
{
    return [[NCKey alloc] initWithChar1:-53
                                  char2:-101
                                  char3:-1
                                  char4:-1
                         representative:'h'];
}

+ (NCKey *) NCKEY_ALT_I
{
    return [[NCKey alloc] initWithChar1:-60
                                  char2:-79
                                  char3:-1
                                  char4:-1
                         representative:'i'];
}

+ (NCKey *) NCKEY_ALT_J
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-120
                                  char3:-102
                                  char4:-1
                         representative:'j'];
}

+ (NCKey *) NCKEY_ALT_K
{
    return [[NCKey alloc] initWithChar1:-62
                                  char2:-86
                                  char3:-1
                                  char4:-1
                         representative:'k'];
}

+ (NCKey *) NCKEY_ALT_L
{
    return [[NCKey alloc] initWithChar1:-17
                                  char2:-84
                                  char3:-127
                                  char4:-1
                         representative:'l'];
}

+ (NCKey *) NCKEY_ALT_M
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-103
                                  char4:-1
                         representative:'m'];
}

+ (NCKey *) NCKEY_ALT_N
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-104
                                  char4:-1
                         representative:'n'];
}

+ (NCKey *) NCKEY_ALT_O
{
    return [[NCKey alloc] initWithChar1:-59
                                  char2:-109
                                  char3:-1
                                  char4:-1
                         representative:'o'];
}

+ (NCKey *) NCKEY_ALT_P
{
    return [[NCKey alloc] initWithChar1:-49
                                  char2:-128
                                  char3:-1
                                  char4:-1
                         representative:'p'];
}

+ (NCKey *) NCKEY_ALT_Q
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-94
                                  char4:-1
                         representative:'q'];
}


+ (NCKey *) NCKEY_ALT_R
{
    return [[NCKey alloc] initWithChar1:-62
                                  char2:-82
                                  char3:-1
                                  char4:-1
                         representative:'r'];
}

+ (NCKey *) NCKEY_ALT_S
{
    return [[NCKey alloc] initWithChar1:-61
                                  char2:-97
                                  char3:-1
                                  char4:-1
                         representative:'s'];
}

+ (NCKey *) NCKEY_ALT_T
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-96
                                  char4:-1
                         representative:'t'];
}

+ (NCKey *) NCKEY_ALT_U
{
    return [[NCKey alloc] initWithChar1:-61
                                  char2:-68
                                  char3:-1
                                  char4:-1
                         representative:'u'];
}

+ (NCKey *) NCKEY_ALT_V
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-128
                                  char3:-71
                                  char4:-1
                         representative:'v'];
}

+ (NCKey *) NCKEY_ALT_W
{
    return [[NCKey alloc] initWithChar1:-50
                                  char2:-87
                                  char3:-1
                                  char4:-1
                         representative:'w'];
}

+ (NCKey *) NCKEY_ALT_X
{
    return [[NCKey alloc] initWithChar1:-30
                                  char2:-119
                                  char3:-120
                                  char4:-1
                         representative:'x'];
}

+ (NCKey *) NCKEY_ALT_Y
{
    return [[NCKey alloc] initWithChar1:-62
                                  char2:-75
                                  char3:-1
                                  char4:-1
                         representative:'y'];
}

+ (NCKey *) NCKEY_ALT_Z
{
    return [[NCKey alloc] initWithChar1:-61
                                  char2:-73
                                  char3:-1
                                  char4:-1
                         representative:'z'];
}

+ (NCKey *) NCKEY_a
{
    return [NCKey SIMPLE:'a'];
}

+ (NCKey *) NCKEY_b
{
    return [NCKey SIMPLE:'b'];
}

+ (NCKey *) NCKEY_c
{
    return [NCKey SIMPLE:'c'];
}

+ (NCKey *) NCKEY_d
{
    return [NCKey SIMPLE:'d'];
}

+ (NCKey *) NCKEY_e
{
    return [NCKey SIMPLE:'e'];
}

+ (NCKey *) NCKEY_f
{
    return [NCKey SIMPLE:'f'];
}

+ (NCKey *) NCKEY_g
{
    return [NCKey SIMPLE:'g'];
}

+ (NCKey *) NCKEY_h
{
    return [NCKey SIMPLE:'h'];
}

+ (NCKey *) NCKEY_i
{
    return [NCKey SIMPLE:'i'];
}

+ (NCKey *) NCKEY_j
{
    return [NCKey SIMPLE:'j'];
}

+ (NCKey *) NCKEY_k
{
    return [NCKey SIMPLE:'k'];
}

+ (NCKey *) NCKEY_l
{
    return [NCKey SIMPLE:'l'];
}

+ (NCKey *) NCKEY_m
{
    return [NCKey SIMPLE:'m'];
}

+ (NCKey *) NCKEY_n
{
    return [NCKey SIMPLE:'n'];
}

+ (NCKey *) NCKEY_o
{
    return [NCKey SIMPLE:'o'];
}

+ (NCKey *) NCKEY_p
{
    return [NCKey SIMPLE:'p'];
}

+ (NCKey *) NCKEY_q
{
    return [NCKey SIMPLE:'q'];
}

+ (NCKey *) NCKEY_r
{
    return [NCKey SIMPLE:'r'];
}

+ (NCKey *) NCKEY_s
{
    return [NCKey SIMPLE:'s'];
}

+ (NCKey *) NCKEY_t
{
    return [NCKey SIMPLE:'t'];
}

+ (NCKey *) NCKEY_u
{
    return [NCKey SIMPLE:'u'];
}

+ (NCKey *) NCKEY_v
{
    return [NCKey SIMPLE:'v'];
}

+ (NCKey *) NCKEY_w
{
    return [NCKey SIMPLE:'w'];
}

+ (NCKey *) NCKEY_x
{
    return [NCKey SIMPLE:'x'];
}

+ (NCKey *) NCKEY_y
{
    return [NCKey SIMPLE:'y'];
}

+ (NCKey *) NCKEY_z
{
    return [NCKey SIMPLE:'z'];
}

+ (NCKey *) NCKEY_A
{
    return [NCKey SIMPLE:'A'];
}

+ (NCKey *) NCKEY_B
{
    return [NCKey SIMPLE:'B'];
}

+ (NCKey *) NCKEY_C
{
    return [NCKey SIMPLE:'C'];
}

+ (NCKey *) NCKEY_D
{
    return [NCKey SIMPLE:'D'];
}

+ (NCKey *) NCKEY_E
{
    return [NCKey SIMPLE:'E'];
}

+ (NCKey *) NCKEY_F
{
    return [NCKey SIMPLE:'F'];
}

+ (NCKey *) NCKEY_G
{
    return [NCKey SIMPLE:'G'];
}

+ (NCKey *) NCKEY_H
{
    return [NCKey SIMPLE:'H'];
}

+ (NCKey *) NCKEY_I
{
    return [NCKey SIMPLE:'I'];
}

+ (NCKey *) NCKEY_J
{
    return [NCKey SIMPLE:'J'];
}

+ (NCKey *) NCKEY_K
{
    return [NCKey SIMPLE:'K'];
}

+ (NCKey *) NCKEY_L
{
    return [NCKey SIMPLE:'L'];
}

+ (NCKey *) NCKEY_M
{
    return [NCKey SIMPLE:'M'];
}

+ (NCKey *) NCKEY_N
{
    return [NCKey SIMPLE:'N'];
}

+ (NCKey *) NCKEY_O
{
    return [NCKey SIMPLE:'O'];
}

+ (NCKey *) NCKEY_P
{
    return [NCKey SIMPLE:'P'];
}

+ (NCKey *) NCKEY_Q
{
    return [NCKey SIMPLE:'Q'];
}

+ (NCKey *) NCKEY_R
{
    return [NCKey SIMPLE:'R'];
}

+ (NCKey *) NCKEY_S
{
    return [NCKey SIMPLE:'S'];
}

+ (NCKey *) NCKEY_T
{
    return [NCKey SIMPLE:'T'];
}

+ (NCKey *) NCKEY_U
{
    return [NCKey SIMPLE:'U'];
}

+ (NCKey *) NCKEY_V
{
    return [NCKey SIMPLE:'V'];
}

+ (NCKey *) NCKEY_W
{
    return [NCKey SIMPLE:'W'];
}

+ (NCKey *) NCKEY_X
{
    return [NCKey SIMPLE:'X'];
}

+ (NCKey *) NCKEY_Y
{
    return [NCKey SIMPLE:'Y'];
}

+ (NCKey *) NCKEY_Z
{
    return [NCKey SIMPLE:'Z'];
}

+ (NCKey *) NCKEY_ENTER
{
    return [NCKey EVENT:(char)10];
}

+ (NCKey *) NCKEY_ESC
{
    return [NCKey EVENT:(char)27];
}

+ (NCKey *) NCKEY_BACK_SPACE
{
    return [NCKey EVENT:(char)127];
}

+ (NCKey *) NCKEY_BLANK_SPACE
{
    return [NCKey SIMPLE:' '];
}

+ (NCKey *) NCKEY_ARROW_UP
{
    return [NCKey EVENT:(char)3];
}

+ (NCKey *) NCKEY_ARROW_DOWN
{
    return [NCKey EVENT:(char)2];
}

+ (NCKey *) NCKEY_ARROW_LEFT
{
    return [NCKey EVENT:(char)4];
}

+ (NCKey *) NCKEY_ARROW_RIGHT
{
    return [NCKey EVENT:(char)5];
}

- (BOOL) isChar1:(char)c1
           char2:(char)c2
           char3:(char)c3
           char4:(char)c4
{
    return (self.c1 == c1 && self.c2 == c2 && self.c3 == c3 && self.c4 == c4);
}

+ (NCKey *)getKeyFromChar1:(char)c1
                     char2:(char)c2
                     char3:(char)c3
                     char4:(char)c4
{
    for(NCKey *key in allKeys) {
        if([key isChar1:c1 char2:c2 char3:c3 char4:c4]) {
            return key;
        }
    }
    return [[NCKey alloc] initWithChar1:c1
                                  char2:c2
                                  char3:c3
                                  char4:c4
                         representative:-1];
}

- (BOOL)isEqual:(NCKey*)object
{
    if(object && [object isKindOfClass:[NCKey class]]) {
        return self.c1 == object.c1 && self.c2 == object.c2 && self.c3 == object.c3 && self.c4 == object.c4;
    }
    return NO;
}

@end
