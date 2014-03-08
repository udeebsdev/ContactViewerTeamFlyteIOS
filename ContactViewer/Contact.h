//
//  Contact.h
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property NSString* name;
@property NSString* title;
@property NSString* phone;
@property NSString* email;
@property NSString* twitter;

-(id) initWithName:(NSString*)newName andTitle:(NSString*)newTitle;

@end
