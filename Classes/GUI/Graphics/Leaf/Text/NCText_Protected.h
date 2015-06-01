//
//  NCText_Protected.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 27/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCText.h"

@interface NCText ()

- (NSArray*) lineBreakAndTruncate:(NCString*)text
                         inBounds:(CGSize)bounds
                        lineBreak:(NCLineBreakMode)lineMode
                        truncMode:(NCLineTruncationMode)trucMode;

- (NCString*) truncateText:(NCString*)text
                  inBounds:(CGSize)bounds
                  withMode:(NCLineTruncationMode)mode;

- (NSArray*) lineBreakText:(NCString*)text
                  inBounds:(CGSize)bounds
                  withMode:(NCLineBreakMode)mode;

@end
