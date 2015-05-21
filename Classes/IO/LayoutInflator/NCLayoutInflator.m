//
//  LayoutInflator.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 21/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCLayoutInflator.h"
#import "NCXMLLayoutParser.h"

@interface NCLayoutInflator () <NCLayoutParserDelegate>
{
    NCLayoutParser *_parser;
    NCGraphic *_root;
    NSMutableArray *_hierarchy;
}
@end

@implementation NCLayoutInflator

- (instancetype)init
{
    self = [super init];
    if(self) {
        _parser = [[NCXMLLayoutParser alloc] init];
        [_parser setDelegate:self];
        _hierarchy = [NSMutableArray array];
    }
    return self;
}

- (NCGraphic*)inflateGraphicFromXML:(NSData*)xml
{
    _root = nil;
    [_hierarchy removeAllObjects];
    [_parser parse:xml];
    return _root;
}

static NCLayoutInflator *instance = nil;
+ (NCLayoutInflator*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NCLayoutInflator alloc] init];
    });
    return instance;
}

+ (NCGraphic *)inflateGraphicFromXML:(NSData *)xml
{
    NCLayoutInflator *inflator = [NCLayoutInflator sharedInstance];
    return [inflator inflateGraphicFromXML:xml];
}

#pragma mark LayoutParserDelegate

- (void)didStartElement:(NSString *)name
         withAttributes:(NSDictionary *)attributes
{
    Class c = NSClassFromString(name);
    if([c isSubclassOfClass:[NCGraphic class]]) {
        NCGraphic *graphic = [[c alloc] initWithAttributes:attributes];
        
        if(!_root) {
            _root = graphic;
        }
        
        if(_hierarchy.lastObject) {
            NCGraphic *parent = (NCGraphic*)_hierarchy.lastObject;
            [parent addChild:graphic];
        }
        
        [_hierarchy addObject:graphic];
    }
}

- (void)didEndElement:(NSString *)name
{
    [_hierarchy removeObject:[_hierarchy lastObject]];
}

@end
