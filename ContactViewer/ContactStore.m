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
    
    Contact *contact1 = [[Contact alloc] initWithName:@"Gregory Jensen" andTitle:@"Best Buy"];
    contact1.alias=@"Greg";
    contact1.phone = @"651-222-4343";
    contact1.email=@"gjensen@gmail.com";
    contact1.address=@"Apple Valley MN";
    contact1.socialNetworkHandle=@"greg";
    
    Contact *contact2 = [[Contact alloc] initWithName:@"Udeeb Shankhadev" andTitle:@"Thomson Reuters"];
    contact2.alias=@"Udeeb";
    contact2.phone = @"651-208-1234";
    contact2.email=@"udeeb@gmail.com";
    contact2.address=@"Eagan MN";
    contact2.socialNetworkHandle=@"udeebsdev";
    
    Contact *contact3 = [[Contact alloc] initWithName:@"Prabina Shrestha" andTitle:@"Thomson Retuers"];
    contact3.alias=@"Prabs";
    contact3.phone = @"651-313-4343";
    contact3.email=@"sprabina@gmail.com";
    contact3.address=@"Eagan MN";
    contact3.socialNetworkHandle=@"sprabina";
    
    Contact *contact4 = [[Contact alloc] initWithName:@"Prapti Shrestha" andTitle:@"Vaddio"];
    contact4.alias=@"Prapti";
    contact4.phone = @"651-313-1234";
    contact4.email=@"praptis@gmail.com";
    contact4.address=@"Eagan MN";
    contact4.socialNetworkHandle=@"praptiS";
    
    Contact *contact5 = [[Contact alloc] initWithName:@"Joseph Whittuhn" andTitle:@"Thomson Reuters"];
    contact5.alias=@"Joe";
    contact5.phone = @"651-313-7701";
    contact5.email=@"joe@gmail.com";
    contact5.address=@"Eagan MN";
    contact5.socialNetworkHandle=@"joeW";
    
    _contacts = @[contact1, contact2, contact3, contact4, contact5];
    return self;
}

@end
