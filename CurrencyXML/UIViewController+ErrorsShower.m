//
//  UIViewController+ErrorsShower.m
//  CurrencyXML
//
//  Created by kkolontay on 7/24/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

#import "UIViewController+ErrorsShower.h"

@implementation UIViewController (ErrorsShower)

- (void) showError: (NSString *) error {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:error preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:
                       ^(UIAlertAction *action) {
                         [alert dismissViewControllerAnimated:YES completion:nil];
                       }];
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:nil];
}

@end
