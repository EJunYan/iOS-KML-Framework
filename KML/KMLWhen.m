//
//  KMLWhen.m
//  KML
//
//  Created by eruYan on 2018/11/29.
//

#import "KMLWhen.h"
#import "KMLElementSubclass.h"

@implementation KMLWhen {
    NSString *_whenValue;
}

@synthesize date = _date;

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _whenValue = [KMLXML textForElement:element];
        _date = [KMLType dateTime:_whenValue];
    }
    return self;
}

#pragma mark - tag

+ (NSString *)tagName
{
    return @"when";
}

- (NSDate *)date {
    if (!_date) {
        if (_whenValue) {
            _date = [KMLType dateTime:_whenValue];
        }
    } else {
        _date = [[NSDate alloc] init];
    }
    return _date;
}


- (void)setDate:(NSDate *)date {
    _whenValue = [KMLType valueForDateTime:date];
}

#pragma mark - KML

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [kml appendFormat: @"\t\t\t\t\t<%@>%@</%@>\r\n"
     , [[self class] tagName]
     , [KMLType valueForDateTime: self.date]
     , [[self class] tagName]];
}


@end
