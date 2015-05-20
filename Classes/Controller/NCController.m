//
//  NCController.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 19/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NCController.h"
#import "NCGraphic.h"
#import "XMLParser.h"
#import "NSObject+Properties.h"

@interface NCController () <ParserDelegate>
{
    NSDictionary *_propertyList;
    NSMutableArray *_hierarchy;
}
@end

@implementation NCController

/*
 <ClassName id="variableName"
            key="value"/>
 
 Each NCGraphic can parse a XML differntly. That way they can all support different keys.
 
 example:
 
 <NCLinearLayout id="linearlayout"
                 orientation="vertical">
    <NCText id="option1">
        <NCString text="[File]"
                  foreground="white"
                  background="black"/>
    </NCText>
    <NCText id="option2">
        <NCString text="[About]"
                  foreground="white"
                  background="black"/>
    </NCText>
 </NCLinearLayout>
 */

- (id)initWithXML:(NSData *)xml
{
    self = [super init];
    if(self) {
        _hierarchy = [NSMutableArray array];
        
        Parser *parser = [[XMLParser alloc] initWithData:xml];
        [parser setDelegate:self];
        [parser parse];
    }
    return self;
}

- (void)setGraphicPropertyWithName:(NSString*)name
                         withValue:(NCGraphic*)graphic
{
    if(!_propertyList) {
        _propertyList = [self properties];
    }
    
    if(name && name.length > 0 && graphic && [graphic isKindOfClass:NSClassFromString([_propertyList objectForKey:name])]) {
        
        NSString *setterName = [NSString stringWithFormat:@"set%c%@:",toupper([name characterAtIndex:0]),[name substringFromIndex:1]];
        SEL setterSelector = NSSelectorFromString(setterName);
        if(setterSelector) {
            [self performSelector:setterSelector
                       withObject:graphic];
        }
    }
}

#pragma mark ParserDelegate

- (void)didStartElement:(NSString *)name
         withAttributes:(NSDictionary *)attributes
{
    Class c = NSClassFromString(name);
    if([c isSubclassOfClass:[NCGraphic class]]) {
        NCGraphic *graphic = [[c alloc] initWithAttributes:attributes];

        [self setGraphicPropertyWithName:[attributes objectForKey:@"id"]
                               withValue:graphic];
        
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
