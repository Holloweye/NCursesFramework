//
//  NCTextEdit.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCText.h"
#import "NCMutableString.h"

@interface NCTextEdit : NCText
/*
 XML keys availiable:
 
 "text" = text
 "foreground" = "black" / "red" / "green" / "yellow" / "blue" / "magenta" / "cyan" / "white"
 "background" = "black" / "red" / "green" / "yellow" / "blue" / "magenta" / "cyan" / "white"
 
 "lineBreak" = "noWrapping" / "charWrapping" / "wordWrapping"
 "truncation" = "clipping" / "truncatingHead" / "truncatingTail"
 
 "horizontalAlignment" = "center" / "right" / "left"
 "verticalAlignment" = "middle" / "top" / "bottom"
 
 "secure" = true/false
 "drawCursor" = true/false
 "maxLength" = nr
 
 */

@property (nonatomic, strong) NCMutableString *text;
@property (nonatomic, assign) CGPoint cursorPosition;

@property (nonatomic, assign) BOOL secure;
@property (nonatomic, assign) BOOL drawCursor;
@property (nonatomic, assign) NSUInteger maxLength;

- (void)addCharacter:(char)c;
- (void)addCharacters:(const char *)chars;
- (void)insertCharacters:(const char *)chars;

- (void)removeCharacters:(int)count;
- (void)deleteCharacters:(int)count;

@end
