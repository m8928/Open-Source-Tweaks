#import <substrate.h>

/* int __cdecl -[SSLGuardWebViewVerifier isJailBroken](SSLGuardWebViewVerifier *self, SEL a2) */
/* bool __cdecl -[BTWCGXMLParser isJailBroken](BTWCGXMLParser *self, SEL a2) */
/* bool __cdecl +[Codeguard isJailBroken](Codeguard_meta *self, SEL a2) */
%hook NSFileManager 
-(bool) changeCurrentDirectoryPath:(NSString *)path {
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
%end

/* [AhnLab] signed __int64 __cdecl -[ams2Library fairPlay:](ams2Library *self, SEL a2, id a3) */
%hook ams2Library
-(long long) fairPlay:(id)arg1 { 
	return %orig - 144; 
	}
%end

/* id __cdecl -[BTWCGXMLParser checkRooting:](BTWCGXMLParser *self, SEL a2, id a3) */
/* char *__fastcall sub_100045730(char *a1) */
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