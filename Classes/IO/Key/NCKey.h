//
//  NCKey.h
//  NCursesLibrary
//
//  Created by Christer on 2014-06-13.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCKey : NSObject

- (char) getCharacter;

+ (NCKey *) getKeyFromChar:(char)c;

+ (NCKey *) NCKEY_a;
+ (NCKey *) NCKEY_b;
+ (NCKey *) NCKEY_c;
+ (NCKey *) NCKEY_d;
+ (NCKey *) NCKEY_e;
+ (NCKey *) NCKEY_f;
+ (NCKey *) NCKEY_g;
+ (NCKey *) NCKEY_h;
+ (NCKey *) NCKEY_i;
+ (NCKey *) NCKEY_j;
+ (NCKey *) NCKEY_k;
+ (NCKey *) NCKEY_l;
+ (NCKey *) NCKEY_m;
+ (NCKey *) NCKEY_n;
+ (NCKey *) NCKEY_o;
+ (NCKey *) NCKEY_p;
+ (NCKey *) NCKEY_q;
+ (NCKey *) NCKEY_r;
+ (NCKey *) NCKEY_s;
+ (NCKey *) NCKEY_t;
+ (NCKey *) NCKEY_u;
+ (NCKey *) NCKEY_v;
+ (NCKey *) NCKEY_w;
+ (NCKey *) NCKEY_x;
+ (NCKey *) NCKEY_y;
+ (NCKey *) NCKEY_z;

+ (NCKey *) NCKEY_A;
+ (NCKey *) NCKEY_B;
+ (NCKey *) NCKEY_C;
+ (NCKey *) NCKEY_D;
+ (NCKey *) NCKEY_E;
+ (NCKey *) NCKEY_F;
+ (NCKey *) NCKEY_G;
+ (NCKey *) NCKEY_H;
+ (NCKey *) NCKEY_I;
+ (NCKey *) NCKEY_J;
+ (NCKey *) NCKEY_K;
+ (NCKey *) NCKEY_L;
+ (NCKey *) NCKEY_M;
+ (NCKey *) NCKEY_N;
+ (NCKey *) NCKEY_O;
+ (NCKey *) NCKEY_P;
+ (NCKey *) NCKEY_Q;
+ (NCKey *) NCKEY_R;
+ (NCKey *) NCKEY_S;
+ (NCKey *) NCKEY_T;
+ (NCKey *) NCKEY_U;
+ (NCKey *) NCKEY_V;
+ (NCKey *) NCKEY_W;
+ (NCKey *) NCKEY_X;
+ (NCKey *) NCKEY_Y;
+ (NCKey *) NCKEY_Z;

+ (NCKey *) NCKEY_ENTER;
+ (NCKey *) NCKEY_BACK_SPACE;
+ (NCKey *) NCKEY_BLANK_SPACE;
+ (NCKey *) NCKEY_ESC;

+ (NCKey *) NCKEY_ARROW_UP;
+ (NCKey *) NCKEY_ARROW_DOWN;
+ (NCKey *) NCKEY_ARROW_LEFT;
+ (NCKey *) NCKEY_ARROW_RIGHT;

@end
