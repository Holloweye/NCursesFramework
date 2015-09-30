//
//  NCText.h
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

typedef enum : NSUInteger {
    NCVerticalAlignmentTop,
    NCVerticalAlignmentMiddle,
    NCVerticalAlignmentBottom,
} NCVerticalAlignment;

@interface NCText : NCGraphic
/*
 XML keys availiable:
 
 "text" = text
 "foreground" = "black" / "red" / "green" / "yellow" / "blue" / "magenta" / "cyan" / "white"
 "background" = "black" / "red" / "green" / "yellow" / "blue" / "magenta" / "cyan" / "white"
 
 "lineBreak" = "noWrapping" / "charWrapping" / "wordWrapping"
 "truncation" = "clipping" / "truncatingHead" / "truncatingTail"
 
 "horizontalAlignment" = "center" / "right" / "left"
 "verticalAlignment" = "middle" / "top" / "bottom"
 
 */

/*
 The text displayed on screen.
 */
@property (nonatomic, strong) NCString *text;

/*
 How to linebreak the text, default is word wrapping.
 */
@property (nonatomic, assign) NCLineBreakMode lineBreak;

/*
 How to truncate the text if needed, default is tail truncation.
 */
@property (nonatomic, assign) NCLineTruncationMode truncation;

/*
 How the text is align in the horizontal axis, default is left.
 */
@property (nonatomic, assign) NCLineAlignment horizontalAlignment;

/*
 How the text is align in the vertical axis, default is top.
 */
@property (nonatomic, assign) NCVerticalAlignment verticalAlignment;

@end
