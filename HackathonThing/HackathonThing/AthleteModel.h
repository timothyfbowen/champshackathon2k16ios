//
//  AthleteModel.h
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AthleteModel : NSObject

@property (strong) NSString *photoURL;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSNumber *gradYear;
@property (strong) NSString *position;
@property (strong) NSNumber *height;
@property (strong) NSNumber *weight;
@property (strong) NSNumber *gpa;
@property (strong) NSString *city;
@property (strong) NSString *state;
@property (strong) NSString *highSchool;
@property (strong) NSNumber *starRating;

@end
