#import <substrate.h>

/* bool __cdecl +[DocumentPath isJailbroken](DocumentPath_meta *self, SEL a2) */
%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

/* void __cdecl -[BCAppDelegate arxanHackingDetected:](BCAppDelegate *self, SEL a2, id a3) */
%hook BCAppDelegate 
- (void)arxanHackingDetected:(id)arg1 {
	;
}
%end