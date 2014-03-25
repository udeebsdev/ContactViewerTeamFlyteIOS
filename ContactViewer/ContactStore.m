//
//  ContactStore.m
//  ContactViewer
//
//  Created by Prabina Shrestha on 3/8/14.
//  Copyright (c) 2014 Flyte. All rights reserved.
//

#import "ContactStore.h"
#import "Contact.h"

@interface ContactStore ()
@end


@implementation ContactStore

+(NSMutableArray*)readContacts{
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts?key=flyte"]];
    // create the request!
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    // get the response!
    NSHTTPURLResponse *reponse = nil;
    NSError* error = [[NSError alloc] init];
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    
    // deserialize the response
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSMutableArray* mutableArrayContact = [self deSerializeContacts:[responseDict objectForKey:@"contacts"]];
    
    return mutableArrayContact;
}

//Deserialize Contacts
+(NSMutableArray*)deSerializeContacts:(NSArray*)rawContacts{
    NSMutableArray *mutableContactsForReading = [[NSMutableArray alloc] init];
    
    for(NSDictionary* dictContact in rawContacts) {
        Contact *contact1 = [self deSerializeIndividualContacts:dictContact];
        [mutableContactsForReading addObject:contact1];
    }
    return mutableContactsForReading;
}

+(Contact*)deSerializeIndividualContacts:(NSDictionary*)dictContact{
    
    Contact *contact1 = [[Contact alloc] initWithName:[dictContact objectForKey:@"name"] andTitle:[dictContact objectForKey:@"title"]];
    contact1._id =[dictContact objectForKey:@"_id"];
    contact1.alias=[dictContact objectForKey:@"alias"];
    contact1.phone = [dictContact objectForKey:@"phone"];
    contact1.email=[dictContact objectForKey:@"email"];
    contact1.address=[dictContact objectForKey:@"address"];
    contact1.socialNetworkHandle=[dictContact objectForKey:@"twitterId"];
    return contact1;
}

// Initialize the whole darn thing!!
+(id)init{
    return self;
}

// Methods for use
+(int) count{
    return [self readContacts].count;
}

+(Contact*) getContactAtIndex : (int) index{
    return [[self readContacts] objectAtIndex: index];
}

+(id)updateContact:(Contact*)contactToUpdate{
    NSString* urlString =[NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts/%@?key=flyte&name=%@&title=%@&email=%@&phone=%@phone&twitterId=%@",contactToUpdate._id, [self getEscapedString:contactToUpdate.name], [self getEscapedString:contactToUpdate.title], [self getEscapedString:contactToUpdate.email], [self getEscapedString:contactToUpdate.phone], [self getEscapedString:contactToUpdate.socialNetworkHandle]];
    
    NSURL* url = [NSURL URLWithString: urlString];
    
    // create the request!
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"PUT"];
    
    // get the response!
    NSHTTPURLResponse *reponse = nil;
    NSError* error = [[NSError alloc] init];
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    // deserialize the response
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    return self;
}

+(id)addContact:(Contact*)newContact{
    NSString* urlString = [NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts?key=flyte&name=%@&title=%@&email=%@&phone=%@phone&twitterId=%@", [self getEscapedString:newContact.name], [self getEscapedString:newContact.title], [self getEscapedString:newContact.email], [self getEscapedString:newContact.phone], [self getEscapedString:newContact.socialNetworkHandle]];
    
    NSURL* url = [NSURL URLWithString: urlString];
    
    // create the request!
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    // get the response!
    NSHTTPURLResponse *reponse = nil;
    NSError* error = [[NSError alloc] init];
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    // deserialize the response
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    return self;
}

+(id)deleteContact:(Contact*)contactToRemove{
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts/%@?key=flyte",contactToRemove._id]];
    // create the request!
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"DELETE"];
    
    // get the response!
    NSHTTPURLResponse *reponse = nil;
    NSError* error = [[NSError alloc] init];
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    // deserialize the response
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    return self;
}

+(Contact*) findContactById:(NSString*)contactID{
    for(Contact* tempContact in [self readContacts])
    {
        if([tempContact._id isEqualToString:contactID]){
            return tempContact;
        }
    }
    return nil;
}

+(NSString*)getEscapedString:(NSString*)unescapedString{
    NSString *escapedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)unescapedString, NULL, CFSTR("!*'();:@&=+$,/?%#[]\" "),kCFStringEncodingUTF8));
    
    return escapedString;
    
}

@end
