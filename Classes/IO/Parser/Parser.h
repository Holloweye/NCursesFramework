//
//  Parser.h
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 20/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParserDelegate <NSObject>
@required
- (void)didStartElement:(NSString*)name
         withAttributes:(NSDictionary*)attributes;

- (void)didEndElement:(NSString*)name;

@end

@interface Parser : NSObject

@property (nonatomic, weak) id<ParserDelegate> delegate;

- (id)initWithData:(NSData*)data;
- (void)parse;

@end
