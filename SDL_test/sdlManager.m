// sdlManager.m
#import "sdlManager.h"

@implementation sdlManager

// To export a module named sdlManager
RCT_EXPORT_MODULE();

// This would name the module AwesomeCalendarManager instead
// RCT_EXPORT_MODULE(AwesomeCalendarManager);

RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
} 

  // NOTE ABOVE EVENT IS A CALENDAR MANAGER EVENT


@end

/*
RCT_EXPORT_METHOD supports all standard JSON object types, such as:

string (NSString)
number (NSInteger, float, double, CGFloat, NSNumber)
boolean (BOOL, NSNumber)
array (NSArray) of any types from this list
object (NSDictionary) with string keys and values of any type from this list
function (RCTResponseSenderBlock)
*/