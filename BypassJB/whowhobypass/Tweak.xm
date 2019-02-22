/* Framework Found: DTTJailbreakDetection */
/* bool __cdecl +[DTTJailbreakDetection isJailbroken](DTTJailbreakDetection_meta *self, SEL a2) */
#import <substrate.h>

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
				} else if([path isEqualToString:@"/usr/bin/ssh"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

static FILE * (*orig_fopen) ( const char * filename, const char * mode );
FILE * new_fopen ( const char * filename, const char * mode ) {
    if (strcmp(filename, "/Applications/Cydia.app") == 0 || strcmp(filename, "/Library/MobileSubstrate/MobileSubstrate.dylib") == 0 || strcmp(filename, "/bin/bash") == 0 || strcmp(filename, "/usr/sbin/sshd") == 0 || strcmp(filename, "/etc/apt") == 0 || strcmp(filename, "/usr/bin/ssh") == 0) {
        return NULL;
    }
    return orig_fopen(filename, mode);
}


%ctor 
{
	@autoreleasepool
	{

		MSHookFunction((void *)fopen, (void *)new_fopen, (void **)&orig_fopen);

	}
}