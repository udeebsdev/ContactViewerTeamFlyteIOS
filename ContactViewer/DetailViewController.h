//
//  DetailViewController.h
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Contact* detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
