/* bool __cdecl -[InitCheck isJailbroken](InitCheck *self, SEL a2) */
/* id __cdecl -[BSAppIron authApp:](BSAppIron *self, SEL a2, id a3) */
/* id __cdecl -[BSAppIron authApp:](BSAppIron *self, SEL a2, id a3) */

#import <substrate.h>
#import <mach-o/dyld.h>

%hook BSAppIron
-(int) IiiIiIiiI {
return 9013; 
}

-(id)authApp:(id)arg1 {
return (id)CFSTR("0000");
%orig;
}
%end


%hook UIApplication 
- (BOOL)canOpenURL:(NSURL *)url {
    if([[url absoluteString] isEqualToString:@"cydia://package/com.example.package"]) {
		return NO;
				}
		else {
					return %orig;
					}
				}
%end

%hook NSString 
- (BOOL)writeToFile:(NSString *)path  {
		if([path isEqualToString:@"/private/jailbreak.txt"]) {
					return NO;
				} 
		else {
					return %orig;
					}
				}
%end


%hook NSFileManager
- (BOOL)removeItemAtPath:(NSString *)path {
		if([path isEqualToString:@"/private/jailbreak.txt"]) {
					return NO;
				} 
		else {
					return %orig;
					}
				}

- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/sbin/sshd"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/apt"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end