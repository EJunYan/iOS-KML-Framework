//
//  KMLGXMultiTrack.m
//  KML
//
//  Created by eruYan on 2018/11/29.
//

#import "KMLGXMultiTrack.h"
#import "KMLElementSubclass.h"

@implementation KMLGXMultiTrack{
    NSMutableArray *_tracks;
}

@synthesize tracks;

#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _tracks = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLAbstractGeometry class]
                        xmlElement:element
                         eachBlock:^(KMLElement *element) {
                             [array addObject:element];
                         }];
        _tracks = array;
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)tracks
{
    return [NSArray arrayWithArray:_tracks];
}

- (void)addTrack:(KMLGXTrack *)track
{
    if (track) {
        NSUInteger index = [_tracks indexOfObject:track];
        if (index == NSNotFound) {
            [_tracks addObject:track];
        }
    }
}

- (void)addTracks:(NSArray *)array
{
    for (KMLGXTrack *track in array) {
        [self addTrack:track];
    }
}

- (void)removeTrack:(KMLGXTrack *)track
{
    NSInteger index = [_tracks indexOfObject:track];
    if (index != NSNotFound) {
        
        [_tracks removeObject:track];
    }
}

#pragma mark - tag

+ (NSString *)tagName
{
    return @"gx:MultiTrack";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLGXTrack *track in self.tracks) {
        
    }
}

@end
