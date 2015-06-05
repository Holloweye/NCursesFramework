//
//  UIColor+Utilities.h
//  ColorAlgorithm
//
//  Created by Quenton Jones on 6/11/11.
//  Copyright 2011 Mysterious Trousers. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSColor (Distance)

// Determines which color in the array of colors most closely matches receiving color.
- (NSColor *)closestColorInPalette:(NSArray *)palette;

@end
