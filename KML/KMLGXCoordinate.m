//
//  KMLCoordinate.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLGXCoordinate.h"
#import "KMLElementSubclass.h"

@implementation KMLGXCoordinate {
    NSString *_longitudeValue;
    NSString *_latitudeValue;
    NSString *_altitudeValue;
}

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize altitude = _altitude;

#pragma mark - instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSString *value;
        double lon;
        double lat;
        double alt;
        value = [KMLXML textForElement:element];
        NSScanner *scanner = [[NSScanner alloc] initWithString:value];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if ([scanner scanDouble:&lon]) {
            _longitudeValue = [[NSNumber numberWithDouble:lon] stringValue];
            _longitude = lon;
        }
        if ([scanner scanDouble:&lat]) {
            _latitudeValue = [[NSNumber numberWithDouble:lat] stringValue];
            _latitude = lat;
        }
        if ([scanner scanDouble:&alt]) {
            _altitudeValue = [[NSNumber numberWithDouble:alt] stringValue];
            _altitude = alt;
        }
    }
    return self;
}

#pragma mark - Public methods

- (CGFloat)longitude
{
    if (!_longitude) {
        if (_longitudeValue) {
            _longitude = [_longitudeValue floatValue];
        } else {
            _longitude = 0.f;
        }
    }
    
    return _longitude;
}

- (void)setLongitude:(CGFloat)longitude
{
    _longitude = longitude;
    _longitudeValue = [NSString stringWithFormat:@"%f", longitude];
}

- (CGFloat)latitude
{
    if (!_latitude) {
        if (_latitudeValue) {
            _latitude = [_latitudeValue floatValue];
        } else {
            _latitude = 0.f;
        }
    }
    
    return _latitude;
}

- (void)setLatitude:(CGFloat)latitude
{
    _latitude = latitude;
    _latitudeValue = [NSString stringWithFormat:@"%f", latitude];
}

- (CGFloat)altitude
{
    if (!_altitude) {
        if (_altitudeValue) {
            _altitude = [_altitudeValue floatValue];
        } else {
            _altitude = 0.f;
        }
    }
    
    return _altitude;
}

- (void)setAltitude:(CGFloat)altitude
{
    _altitude = altitude;
    _altitudeValue = [NSString stringWithFormat:@"%f", altitude];
}


+ (NSString *)tagName
{
    return @"gx:coord";
}

#pragma mark - KML

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [kml appendFormat:@"\t\t\t\t\t<%@>%f %f %f</%@>\r\n"
     , [[self class] tagName]
     , self.longitude
     , self.latitude
     , self.altitude
     , [[self class] tagName]];
}

@end

