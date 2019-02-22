/* bool __cdecl +[SystemUtil isJailBroken](SystemUtil_meta *self, SEL a2) */
/* id __cdecl +[I3GDeviceInfo getJailbreakInfo](I3GDeviceInfo_meta *self, SEL a2) */
/* bool __cdecl -[BTWCGXMLParser isJailBroken](BTWCGXMLParser *self, SEL a2) */
/* bool __cdecl +[Codeguard isJailBroken](Codeguard_meta *self, SEL a2) */
/* id __cdecl -[BTWCGXMLParser checkRooting:](BTWCGXMLParser *self, SEL a2, id a3) */
/* id __cdecl -[BTWCGXMLParser checkRootingWithRCL:](BTWCGXMLParser *self, SEL a2, id a3) */

#import <substrate.h>

%hook BTWCGXMLParser
-(id)checkRootingWithRCL:(id)arg1 {
	return (id)CFSTR("0");
}
%end

%hook I3GDeviceInfo
+(id)getJailbreakInfo {
	return (id)CFSTR("NO");
}
%end

%hook NSFileManager
- (BOOL)changeCurrentDirectoryPath:(NSString *)path {
	if([path isEqualToString:@"/boot/"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/cydia"]) {
					return NO;
				} else {
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
				} else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} else {
					return %orig;
					}
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

MSHook(int, access, const char *pathname, int mode) {
    if (strcmp(pathname, "/etc/apt") == 0 || strcmp(pathname, "/boot/") == 0 || strcmp(pathname, "/Applications/Cydia.app") == 0 || strcmp(pathname, "/private/var/lib/cydia") == 0 || strcmp(pathname, "/bin/bash") == 0 || strcmp(pathname, "/Library/PreferenceBundles/tsProtectorPFBSettings.bundle/Info.plist") == 0 || strcmp(pathname, "/Library/PreferenceBundles/tsProtectorPSettings.bundle/Info.plist") == 0) {
        return -1;
    }
    return _access(pathname, mode);
}

%ctor
{
    @autoreleasepool
    {
	MSHookFunction(access, MSHake(access));	
    }
}