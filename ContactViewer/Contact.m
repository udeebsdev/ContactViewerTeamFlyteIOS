//
//  Contact.m
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@synthesize name, title, phone, email, address, alias, socialNetworkHandle;

-(id) initWithName:(NSString*)newName andTitle:(NSString*)newTitle{
    self = [super init];
    
    self.name = newName;
    self.title = newTitle;

    return self;
}


@end
