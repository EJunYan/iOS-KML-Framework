//
//  KMLGXTrack.m
//  KML
//
//  Created by eruYan on 2018/11/28.
//

#import "KMLGXTrack.h"
#import "KMLWhen.h"
#import "KMLGXCoordinate.h"
#import "KMLElementSubclass.h"
#import "KMLExtendedData.h"
#import "KMLData.h"

@implementation KMLGXTrack {
    NSMutableArray *_coordinates;
    NSMutableArray *_dates;
}

@synthesize coordinates;
@synthesize dates;
@synthesize extendedData = _extendedData;

#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _coordinates = [NSMutableArray array];
        _dates = [NSMutableArray array];
    }
    return self;
}


- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent {
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *dates = [NSMutableArray array];
        NSMutableArray *coordinates = [NSMutableArray array];
        
        [self childElementsOfClass:[KMLWhen class]
                        xmlElement:element
                         eachBlock:^(KMLElement *element) {
                             [dates addObject:element];
                         }];
        [self childElementsOfClass:[KMLGXCoordinate class]
                        xmlElement:element
                         eachBlock:^(KMLElement *element) {
                             [coordinates addObject:element];
                         }];
        _dates = dates;
        _coordinates = coordinates;
        
        _extendedData = (KMLExtendedData *)[self childElementOfClass:[KMLExtendedData class] xmlElement:element];
    }
    return self;
}

- (NSArray *)coordinates
{
    return [NSArray arrayWithArray:_coordinates];
}

- (NSArray *)dates
{
    return [NSArray arrayWithArray:_dates];
}

- (void)setExtendedData:(KMLExtendedData *)extendedData
{
    if (_extendedData != extendedData) {
        if (_extendedData) {
            _extendedData.parent = nil;
        }
        
        _extendedData = extendedData;
        if (_extendedData) {
            _extendedData.parent = self;
        }
    }
}

- (void)addDate:(KMLWhen *)date
{
    if (date) {
        NSUInteger index = [_dates indexOfObject:date];
        if (index == NSNotFound) {
            date.parent = self;
            [_dates addObject:date];
        }
    }
}

- (void)addDates:(NSArray *)array
{
    for (KMLWhen *when in array) {
        [self addDate: when];
    }
}

- (void)removeDate:(KMLWhen *)date
{
    if (date) {
        NSUInteger index = [_dates indexOfObject:date];
        if (index == NSNotFound) {
            date.parent = nil;
            [_dates addObject:date];
        }
    }
}

- (void)addCoordinate:(KMLGXCoordinate *)coordinate
{
    if (coordinate) {
        NSUInteger index = [_coordinates indexOfObject:coordinate];
        if (index == NSNotFound) {
            coordinate.parent = self;
            [_coordinates addObject:coordinate];
        }
    }
}

- (void)addCoordinates:(NSArray *)array
{
    for (KMLGXCoordinate *coordinate in array) {
        [self addCoordinate:coordinate];
    }
}

- (void)removeCoordinate:(KMLGXCoordinate *)coordinate
{
    NSUInteger index = [_coordinates indexOfObject:coordinate];
    if (index != NSNotFound) {
        coordinate.parent = nil;
        [_coordinates removeObject:coordinate];
    }
}

- (NSString *)extendedDataValueForName:(NSString *)name
{
    if (self.extendedData && self.extendedData.dataList) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSArray *array = [self.extendedData.dataList filteredArrayUsingPredicate:predicate];
        if (array.count > 0) {
            KMLData *data = (KMLData *)[array objectAtIndex:0];
            return data.value;
        }
    }
    
    return nil;
}

- (void)addExtendedDataWithName:(NSString *)name value:(NSString *)value
{
    if (!self.extendedData) {
        KMLExtendedData *extendedData = [KMLExtendedData new];
        self.extendedData = extendedData;
    }
//    NSLog(@"加入数据");
    KMLData *data = [KMLData new];
    data.name = name;
    data.value = value;
    [self.extendedData addData:data];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"gx:Track";
}

#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLGXCoordinate *coordinate in self.coordinates) {
        [coordinate kml:kml indentationLevel:indentationLevel];
    }
    
    for (KMLWhen *when in self.dates) {
        [when kml:kml indentationLevel:indentationLevel];
    }
    
    if (self.extendedData) {
//        NSLog(@"生成数据");
        [self.extendedData kml:kml indentationLevel:indentationLevel];
    }
    
}

@end
