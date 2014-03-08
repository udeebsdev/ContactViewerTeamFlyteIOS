//
//  ContactStore.m
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import "ContactStore.h"
#import "Contact.h"

@interface ContactStore (){
    NSArray* _contacts;
}
@end


@implementation ContactStore

-(int) count{
    return _contacts.count;
}

-(Contact*) getContactAtIndex : (int) index{
    //compiler does the auto casting for us
    return [_contacts objectAtIndex: index];
}

-(id)initWithDummies{
    self = [super init];
    _contacts = @[
                 [[Contact alloc] initWithName:@"Prabina Shrestha" andTitle:@"Student"],
                 
                 [[Contact alloc] initWithName:@"Udeeb Shankhadev" andTitle:@"Student"],
                 
                 [[Contact alloc] initWithName:@"Prapti Shrestha" andTitle:@"Student"],
                 
                 [[Contact alloc] initWithName:@"Joe" andTitle:@"Student"],
                 
                 [[Contact alloc] initWithName:@"Greg" andTitle:@"Student"]
                 
                 ];
    
    return self;
}

@end
