//
//  BRGrapeAPIClient.h
//  beRecruitediOS
//
//  Created by Timothy F. Bowen on 4/30/15.
//  Copyright (c) 2015 BeRecruited.com. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface HTTPClient : AFHTTPRequestOperationManager

@property (strong, nonatomic) NSString *authToken;
+ (HTTPClient *)sharedClient;
- (NSDictionary *)paramDictForParams:(NSDictionary *)params;

@end
