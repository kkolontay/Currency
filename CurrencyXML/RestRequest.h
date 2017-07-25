//
//  RestRequest.h
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetcherDataFromServer)(NSData  * _Nullable data, NSString * _Nullable error);

@interface RestRequest : NSObject

+ (id _Nullable ) sharedInstance;
- (void) fetchData:  (FetcherDataFromServer _Nullable ) fetchData;

@end
