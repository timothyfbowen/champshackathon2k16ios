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
    NSInteger labelHeightDelta = 30;
    UIImageView *profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 90, self.frame.size.width - 40, 250)];
    profileImage.contentMode = UIViewContentModeScaleAspectFit;
    int height = profileImage.frame.size.height + profileImage.frame.origin.y + 20;
    [profileImage setImageWithURL:[NSURL URLWithString:self.athlete.photoURL] placeholderImage:[AthleteView getRandomImage]];
    [self insertSubview:profileImage aboveSubview:bg];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, self.frame.size.width - 40, 20)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [NSString stringWithFormat:@"%@ %@ - Class Of %@", self.athlete.firstName, self.athlete.lastName, self.athlete.gradYear];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self insertSubview:nameLabel aboveSubview:bg];
    height += labelHeightDelta;
    UILabel *highSchoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, nameLabel.frame.size.width, 20)];
    highSchoolLabel.textAlignment = NSTextAlignmentCenter;
    highSchoolLabel.textColor = [UIColor whiteColor];
    highSchoolLabel.text = [NSString stringWithFormat:@"%@, %@ GPA", self.athlete.highSchool, self.athlete.gpa];
    
    highSchoolLabel.adjustsFontSizeToFitWidth = YES;
    [self insertSubview:highSchoolLabel aboveSubview:bg];
    height += labelHeightDelta;
    
    UILabel *heightWeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, nameLabel.frame.size.width, 20)];
    heightWeightLabel.textAlignment = NSTextAlignmentCenter;
    heightWeightLabel.textColor = [UIColor whiteColor];
    heightWeightLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", self.athlete.position, self.athlete.heightString, self.athlete.weightString];
    [self insertSubview:heightWeightLabel aboveSubview:bg];
    height += labelHeightDelta;
    
    UILabel *cityStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, nameLabel.frame.size.width, 20)];
    cityStateLabel.textColor = [UIColor whiteColor];
    cityStateLabel.textAlignment = NSTextAlignmentCenter;
    cityStateLabel.text = [NSString stringWithFormat:@"%@, %@", self.athlete.city, self.athlete.state];
    [self insertSubview:cityStateLabel aboveSubview:bg];
}

+ (UIImage *)getRandomImage {
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"Birdman.png", @"Meeseeks.png", @"Morty.png", @"MrGoldenfold.png", @"MuscleRick.png", @"PoopyButthole.png", @"Rick.png", @"Snuffles.png", nil];
    return [UIImage imageNamed:[imageNameArray objectAtIndex:rand() % 7]];
}

@end
