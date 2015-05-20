//
//  NSObject+Properties.m
//  NCursesFramework
//
//  Created by Christer Ulfsparre on 20/05/15.
//  Copyright (c) 2015 ChristerUL. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

- (NSDictionary*)properties
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            [dict setObject:[NSString stringWithCString:propType
                                               encoding:[NSString defaultCStringEncoding]]
                     forKey:[NSString stringWithCString:propName
                                               encoding:[NSString defaultCStringEncoding]]];
        }
    }
    free(properties);
    return dict;
}

@end
