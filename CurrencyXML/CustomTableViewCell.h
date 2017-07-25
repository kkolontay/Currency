//
//  CustomTableViewCell.h
//  CurrencyXML
//
//  Created by kkolontay on 7/25/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *objectOne;
@property (weak, nonatomic) IBOutlet UILabel *objectTwo;

- (void) setData:(NSDictionary *) dictionary;

@end
