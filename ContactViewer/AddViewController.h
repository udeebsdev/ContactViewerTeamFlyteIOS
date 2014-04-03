//
//  EditViewController.h
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Contact.h"

@interface AddViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textName;

@property (weak, nonatomic) IBOutlet UITextField *textAlias;

@property (weak, nonatomic) IBOutlet UITextField *textTitle;

@property (weak, nonatomic) IBOutlet UITextField *textPhone;

@property (weak, nonatomic) IBOutlet UITextField *textAddress;

@property (weak, nonatomic) IBOutlet UITextField *textEmail;

@property (weak, nonatomic) IBOutlet UITextField *textHandle;

@end
