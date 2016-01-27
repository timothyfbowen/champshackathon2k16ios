//
//  AthleteView.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "AthleteView.h"
#import "AthleteModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation AthleteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithAthlete:(AthleteModel *)athlete {
    if (self = [super init]) {
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NCSABG.jpg"]];
    [self addSubview:bg];
}

@end
