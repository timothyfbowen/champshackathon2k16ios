//
//  AthleteModel.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "AthleteModel.h"

@implementation AthleteModel

- (id)initWithDictionary:(NSDictionary *)dict {
    NSMutableDictionary *prunedDictionary = [NSMutableDictionary dictionary];
    for (NSString * key in [dict allKeys])
    {
        if (![[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [prunedDictionary setObject:[dict objectForKey:key] forKey:key];
    }
    if(self = [super init]) {
        NSLog(@"%@", prunedDictionary);
        self.clientID = [prunedDictionary objectForKey:@"client_id"];
        self.photoURL = [prunedDictionary objectForKey:@"thumb_url"];
        self.firstName = [prunedDictionary objectForKey:@"first_name"];
        self.lastName = [prunedDictionary objectForKey:@"last_name"];
        self.gradYear = [prunedDictionary objectForKey:@"graduation_year"];
        self.position = [[prunedDictionary objectForKey:@"position"] objectForKey:@"code"];
        self.height = [prunedDictionary objectForKey:@"height"];
        float feet = [self.height floatValue] / 12.0;
        int inches = [self.height integerValue] % 12;
        self.heightString = [NSString stringWithFormat:@"%u' %u\"", (int)feet, inches];
        self.weight = [prunedDictionary objectForKey:@"weight"];
        self.weightString = [NSString stringWithFormat:@"%@ lbs", self.weight];
        self.gpa = [prunedDictionary objectForKey:@"gpa"];
        self.city = [prunedDictionary objectForKey:@"city"];
        self.state = [prunedDictionary objectForKey:@"state"];
        self.highSchool = [prunedDictionary objectForKey:@"high_school"];
    }
    return self;
}

//maybe do this I dunno
+ (NSString *)capitalizedString {
    return nil;
}

/*
 
 {
 "active?" = 1;
 city = CHICAGO;
 "client_id" = 774389;
 "completed_email_quality_drill?" = 0;
 "completed_onboarding_drill?" = 1;
 email = "mixi.dlatat@test.recruitinginfo.org";
 "first_name" = MIXI;
 "free?" = 0;
 gpa = 4;
 "graduation_year" = 2017;
 height = 71;
 "high_school" = "Sullivan High School";
 "last_name" = DLATAT;
 "payment_grace?" = 0;
 position =     {
 code = Singles;
 "created_at" = "2013-09-30T08:14:02.510Z";
 id = 10263;
 name = Singles;
 "sport_id" = 17689;
 "updated_at" = "2013-09-30T08:14:02.510Z";
 };
 "profile_completion_percentage" = 55;
 "program_name" = "Recruit-Match";
 "recruiting_assessment_complete?" = 0;
 "recruiting_quiz_completed?" = 0;
 "sport_id" = 17689;
 state = ILLINOIS;
 "state_code" = IL;
 "thumb_url" = "https://qa.ncsasports.org/clientrms/assets/default_user_image.png";
 "uploaded_video?" = 0;
 weight = 125;
 }
 
 */


@end
