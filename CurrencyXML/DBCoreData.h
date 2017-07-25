//
//  DBCoreData.h
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCoreData : NSObject

+ (id) sharedInstance;
- (void) setData:(NSMutableArray *)array bankName: (NSString *) bank date: (NSString *) date;
- (long) getCountData;
- (NSDictionary*) fetchObject: (long) index;
- (NSString *) fetchNameOfBank;

@end
