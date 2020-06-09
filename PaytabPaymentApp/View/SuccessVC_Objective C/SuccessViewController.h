//
//  SuccessViewController.h
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuccessViewController : UIViewController

@property(assign, nonatomic) int transactionId;

@property(weak, nonatomic)IBOutlet UILabel *transactionIdLabel;
@end

NS_ASSUME_NONNULL_END
