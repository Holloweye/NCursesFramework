//
//  BKAsciiConverter.m
//  BKAsciiImage
//
//  Copyright (c) 2014 Barış Koç (https://github.com/bkoc)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BKAsciiConverter.h"
#import "BKAsciiConverter_Internal.h"
#import "BKAsciiDefinition.h"
#import "NSColor+Distance.h"
#import "NCColor.h"
#import "Logger.h"

#define kDefaultFontSize 10.0

@interface BKAsciiConverter ()
@property (strong, nonatomic) BKAsciiDefinition* definition;
@end


@implementation BKAsciiConverter

- (instancetype)init{
    self = [super init];
    if (self) {
        _definition = [[BKAsciiDefinition alloc] init];
        [self initDefaults];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)luminanceToStringMapping{
    self = [super init];
    
    if (self) {
        _definition = [[BKAsciiDefinition alloc] initWithDictionary:luminanceToStringMapping];
        [self initDefaults];
    }
    return self;
}

- (instancetype)initWithDefinition:(BKAsciiDefinition*)definition{
    self = [super init];
    if (self) {
        _definition = definition;
        [self initDefaults];
    }
    return self;
}

- (void)initDefaults{
    _font = [NSFont systemFontOfSize:kDefaultFontSize];
    _backgroundColor = [NSColor clearColor];
    _grayscale = NO;
    _reversedLuminance = YES; // reverse by default assuming used with a dark bg color
    _columns = 0;
}

#pragma mark - Ascii String
- (void)convertToCharsAndColors:(NSImage*)input
                     withColors:(NSArray*)colors
               withActualColors:(NSArray *)actualColors
                       withMode:(ImageScale)mode
                      withWidth:(int)width
                     withHeight:(int)height
                   onCompletion:(void (^)(int *, int, int))completion
{
    NSImage *scaledImage = [self scaleImage:input
                                  withWidth:width
                                 withHeight:height
                                   withMode:mode];
    BlockGrid *pixelGrid = [self pixelGridForImage:scaledImage];
    
    int *matrix = malloc(sizeof(int) * pixelGrid.width * pixelGrid.height);
    
    for (int y=0; y < pixelGrid.height; y++) {
        for (int x=0; x < pixelGrid.width; x++) {
            int col = x; int row = y;
            block_t block = [pixelGrid blockAtRow:row col:col];
            CGFloat luminance = [self _luminance:block];
            NSString *ascii = [self.definition stringForLuminance: luminance];
            
            char c = (ascii.length > 0 ? [ascii characterAtIndex:0] : ' ');
            Color fg = ColorBlack;
            Color bg = ColorWhite;
            
            NSColor *color = [[NSColor colorWithRed:block.r green:block.g blue:block.b alpha:1.0] closestColorInPalette:actualColors];
            for(NSUInteger i = 0; i < actualColors.count; i++) {
                NSColor *color2 = [actualColors objectAtIndex:i];
                if(color.redComponent == color2.redComponent &&
                   color.greenComponent == color2.greenComponent &&
                   color.blueComponent == color2.blueComponent) {
                    bg = (Color)[[colors objectAtIndex:i] unsignedLongValue];
                    break;
                }
            }
            
            const int i = x * pixelGrid.height + y;
            matrix[i] = c + fg * 1000 + bg * 10000;
        }
    }

    if(completion) {
        completion(matrix, pixelGrid.width, pixelGrid.height);
    }
}

#pragma mark - Helpers

-(BlockGrid*)pixelGridForImage:(NSImage*)image{
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    CGImageRef imageRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    //  Determine the desired index by multiplying row * column.
    BlockGrid * grid = [[BlockGrid alloc] initWithWidth:(int)width height:(int)height];
    block_t block;
    for (int row = 0; row < width; row++) {
        for (int col = 0; col < height; col++) {
            // Now rawData contains the image data in the RGBA8888 pixel format.
            int byteIndex = ((int)bytesPerRow * col) + row * (int)bytesPerPixel;
            
            block.r = (rawData[byteIndex]) / 255.0;
            block.g = (rawData[byteIndex + 1]) / 255.0;;
            block.b = (rawData[byteIndex + 2]) / 255.0;;
            block.a = (rawData[byteIndex + 3]) / 255.0;
            
            [grid copyBlock:&block toRow:col col:row]; // the image is in the wrong orientation. Rotate row & col
        }
    }
    free(rawData);
    
    return grid;
}

-(NSImage*)scaleImage:(NSImage*)image
            withWidth:(int)width
           withHeight:(int)height
             withMode:(ImageScale)mode
{
    CGSize size = CGSizeMake(width, height);
    if(mode == ImageScaleAspectFit) {
        CGFloat factor = (image.size.width > image.size.height) ? width / image.size.width : height / image.size.height;
        size = CGSizeMake(image.size.width * factor, image.size.height * factor);
    }
    
    NSImage* scaledImage = [[NSImage alloc] initWithSize:CGSizeMake(width/2, height/2)];
    [scaledImage lockFocus];
    [[NSColor blackColor] drawSwatchInRect:CGRectMake(0, 0, size.width/2, size.height/2)];
    [image drawInRect:CGRectMake(width/4 - size.width/4,
                                 height/4 - size.height/4,
                                 size.width/2,
                                 size.height/2)];
    [scaledImage unlockFocus];

    if(mode == ImageScaleAspectFill) {
        CGImageRef imageRef = CGImageCreateWithImageInRect([self newCGImageRef:scaledImage], CGRectMake(0, 0, width, height));
        scaledImage = [self newImageWithCGImageRef:imageRef];
        CGImageRelease(imageRef);
    }
    return scaledImage;
}

-(CGImageRef)newCGImageRef:(NSImage*)image
{
    NSData* cocoaData = [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: [image representations]];
    CFDataRef carbonData = (__bridge CFDataRef)cocoaData;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData(carbonData, NULL);
    CGImageRef out = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, NULL);
    return out;
}

- (NSImage *)newImageWithCGImageRef:(CGImageRef)cgImage
{
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:cgImage];
    NSImage *image = [[NSImage alloc] init];
    [image addRepresentation:bitmapRep];
    return image;
}

- (BOOL)isTransparent{
    if (self.backgroundColor == nil || [self.backgroundColor isEqual:[NSColor clearColor]])
        return YES;
    else
        return NO;
}


- (CGFloat)_gridWidth:(CGFloat)width{
    CGFloat asciiGridWidth;
    if (self.columns == 0) {
        asciiGridWidth = width/self.font.pointSize;
    }
    else{
        asciiGridWidth = self.columns;
    }
    return asciiGridWidth;
}

- (CGFloat)_luminance:(block_t)block{
    // See wikipedia article on grayscale for an explanation of this formula.
    // http://en.wikipedia.org/wiki/Grayscale
    float luminance = 0.2126 * block.r + 0.7152 * block.g + 0.0722 * block.b;
    if (self.reversedLuminance) {
        luminance = (1.0 - luminance);
    }
    return luminance;
}
@end


