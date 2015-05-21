//
//  LayoutInflator.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCGraphic.h"

@interface NCLayoutInflator : NSObject

+ (NCGraphic*)inflateGraphicFromXML:(NSData*)xml;

@end
