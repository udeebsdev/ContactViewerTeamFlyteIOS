//
//  ContactStore.h
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactStore : NSObject

-(int) count;
-(Contact*) getContactAtIndex : (int) index;
-(id)initWithDummies;
-(id)addContact:(Contact*) newContact;
-(id)deleteContact:(Contact*)contactToRemove;
-(id)updateContact:(Contact*)contactToUpdate;
@end
