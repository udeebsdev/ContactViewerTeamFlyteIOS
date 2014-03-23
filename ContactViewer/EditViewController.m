//
//  EditViewController.m
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import "EditViewController.h"

#import "ContactStore.h"

@interface EditViewController (){
    
    ContactStore* _contactStore;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _contactStore = [[ContactStore alloc] initWithDummies];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(Contact*) newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}
- (void)configureView
{
    // Update the user interface for the edit item.
    
    if (self.detailItem) {
        self.textName.text = self.detailItem.name;
        self.textAlias.text = self.detailItem.alias;
        self.textTitle.text = self.detailItem.title;
        self.textPhone.text = self.detailItem.phone;
        self.textEmail.text = self.detailItem.email;
        self.textAddress.text = self.detailItem.address;
        self.textHandle.text = self.detailItem.socialNetworkHandle;
    }
}


- (IBAction) actionSave:(id)sender {
    
    //TODO: persist changes
    self.detailItem.name = self.textName.text;
    self.detailItem.alias = self.textAlias.text;
    self.detailItem.title = self.textTitle.text;
    self.detailItem.phone = self.textPhone.text;
    self.detailItem.email = self.textEmail.text;
    self.detailItem.address = self.textAddress.text;
    self.detailItem.socialNetworkHandle = self.textHandle.text;
       
    [_contactStore updateContact:self.detailItem];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) actionDelete:(id)sender {
    
    [_contactStore deleteContact:self.detailItem];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
