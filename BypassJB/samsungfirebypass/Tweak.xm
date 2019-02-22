/* AhnLab Class Detected, AHN_3379024345_TK */
/* int __cdecl +[KSFileUtil checkJailBreak](KSFileUtil_meta *self, SEL a2) */
/* id __cdecl +[ixcJailBreakDetect isJailbroken](ixcJailBreakDetect_meta *self, SEL a2) */
/* bool __cdecl +[ixcSecureManager checkJailbreak](ixcSecureManager_meta *self, SEL a2) */
/* bool __cdecl +[ixcJailBreakDetect findPiratedApps](ixcJailBreakDetect_meta *self, SEL a2) */
/* bool __cdecl -[ANSMetadata computeIsJailbroken](ANSMetadata *self, SEL a2) */
/* id __cdecl -[JailBreakChecker isJailBreak](JailBreakChecker *self, SEL a2) */
#import <substrate.h>

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/sh"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/cydia"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

%hook KSFileUtil
+(int) checkJailBreak {
	return 1;
}
%end

%hook amsLibrary
-(long long) a3142:(id)arg1 { 
	return %orig - 10; 
}
%end