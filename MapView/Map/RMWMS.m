//
//  RMWMS.m
//
// Copyright (c) 2008-2013, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "RMWMS.h"

@implementation RMWMS
{
    NSString *_urlPrefix;
}

@synthesize layers = _layers;
@synthesize styles = _styles;
@synthesize queryLayers = _queryLayers;
@synthesize queryable = _queryable;
@synthesize crs = _crs;
@synthesize infoFormat = _infoFormat;
@synthesize format = _format;
@synthesize service = _service;
@synthesize version = _version;
@synthesize exceptions = _exceptions;
@synthesize extraKeyValues = _extraKeyValues;

- (id) init
{
    if (!(self = [super init]))
        return nil;

    // default values
    self.infoFormat = @"text/html";
    self.crs = @"EPSG:900913";
    self.layers = @"";
    self.queryLayers = @"";
    self.styles = @"";
    self.format = @"image/png";
    self.service = @"WMS";
    self.version = @"1.1.1";
    self.exceptions = @"application/vnd.ogc.se_inimage";
    self.extraKeyValues = @"";

    return self;
}

- (void) dealloc
{
    self.urlPrefix = nil;
    self.layers = nil;
    self.styles = nil;
    self.queryLayers = nil;
    self.crs = nil;
    self.infoFormat = nil;
    self.format = nil;
    self.service = nil;
    self.version = nil;
    self.exceptions = nil;
    self.extraKeyValues = nil;
    [super dealloc];
}

#pragma mark -

- (NSString *)urlPrefix
{
    return _urlPrefix;
}

- (void)setUrlPrefix:(NSString *)newUrlPrefix
{
    if (newUrlPrefix)
    {
        if ( ! ([newUrlPrefix hasSuffix:@"?"] || [newUrlPrefix hasSuffix:@"&"]))
        {
            if ([newUrlPrefix rangeOfString:@"?"].location == NSNotFound)
                newUrlPrefix = [newUrlPrefix stringByAppendingString:@"?"];
            else
                newUrlPrefix = [newUrlPrefix stringByAppendingString:@"&"];
        }
    }

    [_urlPrefix release];
    _urlPrefix = [newUrlPrefix retain];
}

- (NSString *)createBaseGet:(NSString *)bbox size:(CGSize)size
{
    return [NSString stringWithFormat:@"%@FORMAT=%@&SERVICE=%@&VERSION=%@&EXCEPTIONS=%@&SRS=%@&BBOX=%@&WIDTH=%.0f&HEIGHT=%.0f&LAYERS=%@&STYLES=%@%@", 
            self.urlPrefix, self.format, self.service, self.version, self.exceptions, self.crs, bbox, size.width, size.height, self.layers, self.styles, self.extraKeyValues];
}

- (NSString *)createGetMapForBbox:(NSString *)bbox size:(CGSize)size
{
    return [NSString stringWithFormat:@"%@&REQUEST=GetMap", [self createBaseGet:bbox size:size]];
}

- (NSString *)createGetFeatureInfoForBbox:(NSString *)bbox size:(CGSize)size point:(CGPoint)point
{
    return [NSString stringWithFormat:@"%@&REQUEST=GetFeatureInfo&INFO_FORMAT=%@&X=%.0f&Y=%.0f&QUERY_LAYERS=%@",
            [self createBaseGet:bbox size:size], self.infoFormat, point.x, point.y, self.queryLayers];
}

- (NSString *)createGetCapabilities
{
    return [NSString stringWithFormat:@"%@SERVICE=%@&VERSION=%@&REQUEST=GetCapabilities",
            self.urlPrefix, self.service, self.version];
}

- (BOOL)isVisible
{
    return self.layers.length > 0;
}

- (void)setExtraKeyValueDictionary:(NSDictionary *)kvd
{
    NSMutableString *s = [NSMutableString string];

    for (NSString *key in kvd)
    {
        NSString *value = kvd[key];

        [s appendFormat:@"&%@=%@", key, [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    [self setExtraKeyValues:[NSString stringWithString:s]];
}

// [ layerA, layer B ] -> layerA,layerB
+ (NSString *)escapeAndJoin:(NSArray *)elements
{
    NSMutableArray *encoded = [NSMutableArray array];

    for (NSString *element in elements)
    {
        [encoded addObject:[element stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    return [encoded componentsJoinedByString:@","];
}

// layerA,layerB -> [ layerA, layer B ]
+ (NSArray *)splitAndDecode:(NSString *)joined
{
    NSMutableArray *split = [NSMutableArray array];

    if ([joined length] == 0)
        return split;

    for (NSString *element in [joined componentsSeparatedByString:@","])
    {
        [split addObject:[element stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    return split;
}

- (NSArray *)selectedLayerNames
{
    return [RMWMS splitAndDecode:self.layers];
}

- (void)setSelectedLayerNames:(NSArray *)layerNames
{
    [self setLayers:[RMWMS escapeAndJoin:layerNames]];
}

- (NSArray *)selectedQueryLayerNames
{
    return [RMWMS splitAndDecode:self.queryLayers];
}

- (void)setSelectedQueryLayerNames:(NSArray *)layerNames
{
    [self setQueryLayers:[RMWMS escapeAndJoin:layerNames]];
}

- (BOOL)selected:(NSString *)layerName
{
    return [[self selectedLayerNames] containsObject:layerName];
}

- (void)select:(NSString *)layerName queryable:(BOOL)isQueryable
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self selectedLayerNames]];

    if ( ! [array containsObject:layerName])
    {
        [array addObject:layerName];
        [self setSelectedLayerNames:array];
    }

    if (isQueryable)
    {
        array = [NSMutableArray arrayWithArray:[self selectedQueryLayerNames]];

        if ( ! [array containsObject:layerName])
        {
            [array addObject:layerName];
            [self setSelectedQueryLayerNames:array];
        }
    }
}

- (void)deselect:(NSString *)layerName
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self selectedLayerNames]];
    [array removeObject:layerName];
    [self setSelectedLayerNames:array];

    array = [NSMutableArray arrayWithArray:[self selectedQueryLayerNames]];
    [array removeObject:layerName];
    [self setSelectedQueryLayerNames:array];
}

@end
