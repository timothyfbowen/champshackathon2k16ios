//
//  SwipeViewController.h
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>


@interface SwipeViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (strong) MDCSwipeToChooseViewOptions *options;
@end
