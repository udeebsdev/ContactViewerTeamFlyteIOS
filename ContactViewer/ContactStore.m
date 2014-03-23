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

-(id)init{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    _contacts = [prefs arrayForKey:@"flyteContacts"];
    
    return self;
}

-(void)reLoadContacts{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Read from the NSUserDefaults
    NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
    
    _contacts = [NSArray arrayWithArray:mutableContactsForReading];
}

-(id)updateContact:(Contact*)contactToUpdate{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Read from the NSUserDefaults
    NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
  
    for(Contact* tempContact in  mutableContactsForReading)
    {
        if(tempContact._id == contactToUpdate._id){
            tempContact.name =  contactToUpdate.name;
            tempContact.phone = contactToUpdate.phone;
            tempContact.title = contactToUpdate.title;
            tempContact.email = contactToUpdate.email;
            tempContact.address = contactToUpdate.address;
            tempContact.socialNetworkHandle = contactToUpdate.socialNetworkHandle;
            tempContact.alias = contactToUpdate.alias;
            
            _contacts = [NSArray arrayWithArray:mutableContactsForReading];
            
            NSMutableArray *mutableContacts = [self serializeContacts:mutableContactsForReading];
            [prefs setObject:mutableContacts forKey:@"flyteContacts"];

            
            break;
        }
    }
    
    return self;
}

-(id)addContact:(Contact*)newContact{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    // Read from the NSUserDefaults
    NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
    [mutableContactsForReading addObject:newContact];
    
    _contacts = [NSArray arrayWithArray:mutableContactsForReading];
    
    NSMutableArray *mutableContacts = [self serializeContacts:mutableContactsForReading];
    [prefs setObject:mutableContacts forKey:@"flyteContacts"];
    
    return self;
}

-(id)deleteContact:(Contact*)contactToRemove{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Read from the NSUserDefaults
    NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
    int contactToRemoveIndex = -1;
    for(int i=0; i< mutableContactsForReading.count; i++)
    {
        Contact* tempContact = [mutableContactsForReading objectAtIndex:i];
        if(tempContact._id == contactToRemove._id){
            contactToRemoveIndex = i;
            break;
        }
    }
    
    if(contactToRemoveIndex >= 0){
        [mutableContactsForReading removeObjectAtIndex:contactToRemoveIndex];
    
        _contacts = [NSArray arrayWithArray:mutableContactsForReading];
    
        NSMutableArray *mutableContacts = [self serializeContacts:mutableContactsForReading];
        [prefs setObject:mutableContacts forKey:@"flyteContacts"];
    }
    return self;
}

-(Contact*) findContactById:(NSString*)contactID{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Read from the NSUserDefaults
    NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
    
    for(Contact* tempContact in mutableContactsForReading)
    {
        if(tempContact._id == contactID){
            return tempContact;
        }
    }
    return nil;
}

-(Contact*)deSerializeIndividualContacts:(NSDictionary*)dictContact{
   
        Contact *contact1 = [[Contact alloc] initWithName:[dictContact objectForKey:@"Name"] andTitle:[dictContact objectForKey:@"Title"]];
        contact1._id =[dictContact objectForKey:@"ID"];
        contact1.alias=[dictContact objectForKey:@"Alias"];
        contact1.phone = [dictContact objectForKey:@"Phone"];
        contact1.email=[dictContact objectForKey:@"Email"];
        contact1.address=[dictContact objectForKey:@"Address"];
        contact1.socialNetworkHandle=[dictContact objectForKey:@"Handle"];
    return contact1;
}


-(NSMutableArray*)deSerializeContacts:(NSArray*)rawContacts{
    NSMutableArray *mutableContactsForReading = [[NSMutableArray alloc] init];
    
    for(NSDictionary* dictContact in rawContacts) {
        Contact *contact1 = [self deSerializeIndividualContacts:dictContact];
        [mutableContactsForReading addObject:contact1];
    }
    return mutableContactsForReading;
}

-(id)initWithDummies{
    self = [super init];
    
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Read from the NSUserDefaults
     NSArray* rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    
    // If there is not contact then create new
    if(rawContacts == nil || rawContacts.count ==0){
        [self createDummyContacts];
        rawContacts  = [[NSArray alloc] initWithArray:[prefs arrayForKey:@"flyteContacts"]];
    }
   
    NSMutableArray *mutableContactsForReading  = [self deSerializeContacts:rawContacts];
    
    _contacts = [NSArray arrayWithArray:mutableContactsForReading];

    return self;
}


-(NSMutableDictionary*) serializeIndividualContact:(Contact*) contactItem{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:contactItem._id forKey:@"ID"];
    [dict setValue:contactItem.name forKey:@"Name"];
        [dict setValue:contactItem.title forKey:@"Title"];
        [dict setValue:contactItem.alias forKey:@"Alias"];
        [dict setValue:contactItem.phone forKey:@"Phone"];
        [dict setValue:contactItem.email forKey:@"Email"];
        [dict setValue:contactItem.address forKey:@"Address"];
        [dict setValue:contactItem.socialNetworkHandle forKey:@"Handle"];
    
    return dict;
    
}

-(NSMutableArray*) serializeContacts:(NSArray*) contactsToSerialize{
    NSMutableArray *mutableContacts = [[NSMutableArray alloc] init];
    
    for(Contact* contactItem in contactsToSerialize) {
        NSMutableDictionary *dict = [self serializeIndividualContact: contactItem];
        [mutableContacts addObject:dict];
    }
    
    return mutableContacts;
    
}


-(id) createDummyContacts{
    // Create some sample contacts
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
    
    NSArray *tempContacts = @[contact1, contact2, contact3, contact4, contact5];
    
    NSMutableArray *mutableContacts = [self serializeContacts:tempContacts];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:mutableContacts forKey:@"flyteContacts"];
    
    return self;
}


@end
