//
//  NCSource.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCSource : NSObject

- (id)initWithString:(NSString*)string;

- (char) currentChar;
- (char) nextChar;
- (char) peekChar;

- (int) getCharacterPosition;

@end
