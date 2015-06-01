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

@property (nonatomic, strong) NCMutableString *text;
@property (nonatomic, assign) CGPoint cursorPosition;

- (void)addCharacter:(char)c
                  at:(CGPoint)pos;

- (void)deleteCharacterAt:(CGPoint)pos;

@end
