//
//  KMLCoordinate.h
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMLElement.h"

/** Coordinate type.
 
 The KML Framework follows KML standard specification.
 You can see the Google's KML reference at http://code.google.com/apis/kml/documentation/kmlreference.html
 */
@interface KMLGXCoordinate : KMLElement


/// ---------------------------------
/// @name Accessing Properties
/// ---------------------------------

/** Latitude */
@property (nonatomic, assign) CGFloat latitude;

/** Longitude */
@property (nonatomic, assign) CGFloat longitude;

/** Altitude */
@property (nonatomic, assign) CGFloat altitude;

@end

