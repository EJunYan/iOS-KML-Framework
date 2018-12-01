//
//  KMLGXTrack.h
//  KML
//
//  Created by eruYan on 2018/11/28.
//

#import <Foundation/Foundation.h>
#import "KMLAbstractGeometry.h"

@class KMLGXCoordinate;

@class KMLWhen;

@class KMLExtendedData;

NS_ASSUME_NONNULL_BEGIN

@interface KMLGXTrack : KMLAbstractGeometry

@property (strong, nonatomic, readonly) NSArray *coordinates;

@property (strong, nonatomic, readonly) NSArray *dates;

@property (strong, nonatomic) KMLExtendedData *extendedData;

- (void)addDate:(KMLWhen *)date;

- (void)addDates:(NSArray *)array;

- (void)removeDate:(KMLWhen *)date;

- (void)addCoordinate:(KMLGXCoordinate *)coordinate;

- (void)addCoordinates:(NSArray *)array;

- (void)removeCoordinate:(KMLGXCoordinate *)coordinate;

- (NSString *)extendedDataValueForName:(NSString *)name;

- (void)addExtendedDataWithName:(NSString *)name value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
