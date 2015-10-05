//
//  Logger.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-15.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (void)initialize
{
    if([[NSFileManager defaultManager] fileExistsAtPath:[Logger logPath]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[Logger logPath]
                                                   error:nil];
    }
}

+ (void) log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    int timestamp = [[NSDate date] timeIntervalSince1970];
    int hour = (timestamp % 86400) / 3600;
    int min = (timestamp % 3600) / 60;
    int sec = (timestamp % 60);
    
    va_list ap;
    va_start(ap, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    text = [NSString stringWithFormat:@"%i:%i:%i %@\n",hour,min,sec,text];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[Logger logPath]]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[Logger logPath]];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    } else {
        [text writeToFile:[Logger logPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

+ (NSString*)logPath
{
    return [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),@"ncursesframework_log.txt"];
}

@end
