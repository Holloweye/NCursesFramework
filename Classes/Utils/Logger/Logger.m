//
//  Logger.m
//  NCursesLibrary
//
//  Created by Christer on 2014-06-15.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (void) log:(NSString *)text
{
    int timestamp = [[NSDate date] timeIntervalSince1970];
    int hour = (timestamp % 86400) / 3600;
    int min = (timestamp % 3600) / 60;
    int sec = (timestamp % 60);
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
    return @"/Users/Christer/Desktop/log.txt";
}

@end
