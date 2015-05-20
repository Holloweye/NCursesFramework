//
//  XMLParser.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 20/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser () <NSXMLParserDelegate>
{
    NSData *_data;
}
@end

@implementation XMLParser

- (id)initWithData:(NSData *)data
{
    self = [super initWithData:data];
    if(self) {
        _data = data;
    }
    return self;
}

- (void)parse
{
    if(_data) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
        [parser setDelegate:self];
        [parser parse];
    }
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    [self.delegate didStartElement:elementName
                    withAttributes:attributeDict];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    [self.delegate didEndElement:elementName];
}

@end
