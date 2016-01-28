//
//  AthleteView.h
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@class AthleteModel;

@interface AthleteView : MDCSwipeToChooseView

@property (strong) AthleteModel *athlete;

//- (id)initWithAthlete:(AthleteModel *)athlete;
- (id)initWithAthlete:(AthleteModel *)athlete andOptions:(MDCSwipeToChooseViewOptions *)options;
+ (UIImage *)getRandomImage ;

@end
