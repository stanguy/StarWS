//
//  KeolisRennesAPI.h
//  StarWS
//
//  Created by Sebastien Tanguy on 1/13/13.
//  Copyright (c) 2013 Sebastien Tanguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Line;
@class Stop;
@class APIStopTime;

@interface KeolisRennesAPI : NSObject

- (APIStopTime*) findNextDepartureAtStop:(Stop*)stop;

@property (nonatomic,retain) NSString* key;

@end
