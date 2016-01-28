//
//  AthleteView.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "AthleteView.h"
#import "AthleteModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation AthleteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithAthlete:(AthleteModel *)athlete andOptions:(MDCSwipeToChooseViewOptions *)options {
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds] options:options]) {
        self.athlete = athlete;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NCSABG.jpg"]];
    [self addSubview:bg];
    [self sendSubviewToBack:bg];
    UIImageView *profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 3.0, 20, self.frame.size.width / 3.0, 150)];
    int height = profileImage.frame.size.height + profileImage.frame.origin.y + 20;
    [profileImage setImageWithURL:[NSURL URLWithString:self.athlete.photoURL]];
    [self insertSubview:profileImage aboveSubview:bg];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, self.frame.size.width - 40, 20)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [NSString stringWithFormat:@"%@ %@ - Class Of %@", self.athlete.firstName, self.athlete.lastName, self.athlete.gradYear];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self insertSubview:nameLabel aboveSubview:bg];
    height += 40;
    UILabel *highSchoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, nameLabel.frame.size.width, 20)];
    highSchoolLabel.textAlignment = NSTextAlignmentCenter;
    highSchoolLabel.textColor = [UIColor whiteColor];
    highSchoolLabel.text = [NSString stringWithFormat:@"%@, %@ GPA", self.athlete.highSchool, self.athlete.gpa];
    
    highSchoolLabel.adjustsFontSizeToFitWidth = YES;
    [self insertSubview:highSchoolLabel aboveSubview:bg];
                            
    
    
}

@end
