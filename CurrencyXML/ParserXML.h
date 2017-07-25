//
//  ParserXML.h
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserXML : NSObject <NSXMLParserDelegate>

- (id) initWithData: (NSData *) data;
- (void) parsing;
- (NSString *) getNameOfBank;
- (NSString *) getDate;

@end
