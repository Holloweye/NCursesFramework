//
//  NCGraphicText.h
//  NCursesF
//
//  Created by Christer on 2015-03-10.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCGraphic.h"
#import "NCString.h"

typedef enum : NSUInteger {
    NCLineBreakByNoWrapping,
    NCLineBreakByWordWrapping,
    NCLineBreakByCharWrapping,
} NCLineBreakMode;

typedef enum : NSUInteger {
    NCLineTruncationByClipping,
    NCLineTruncationByTruncatingHead,
    NCLineTruncationByTruncationTail,
} NCLineTruncationMode;

typedef enum : NSUInteger {
    NCLineAlignmentLeft,
    NCLineAlignmentCenter,
    NCLineAlignmentRight,
} NCLineAlignment;

@interface NCText : NCGraphic

@property (nonatomic, strong) NCString *text;
@property (nonatomic, assign) NCLineBreakMode lineBreak;
@property (nonatomic, assign) NCLineTruncationMode truncation;
@property (nonatomic, assign) NCLineAlignment alignment;

@end
