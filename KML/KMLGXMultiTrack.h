//
//  KMLGXMultiTrack.h
//  KML
//
//  Created by eruYan on 2018/11/29.
//

#import <Foundation/Foundation.h>
#import "KMLAbstractGeometry.h"



@class KMLGXTrack;

NS_ASSUME_NONNULL_BEGIN
/// 暂未实现
@interface KMLGXMultiTrack : KMLAbstractGeometry

@property (strong, nonatomic, readonly) NSArray *tracks;

- (void)addTrack:(KMLGXTrack *)track;

- (void)addTracks:(NSArray *)array;

- (void)removeTrack:(KMLGXTrack *)track;

@end

NS_ASSUME_NONNULL_END
