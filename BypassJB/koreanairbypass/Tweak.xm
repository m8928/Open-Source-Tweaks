%hook NSString 
- (BOOL)writeToFile:(NSString *)path  {
		if([path isEqualToString:@"/private/jailbreak.txt"]) {
					return NO;
				} 
		else if([path isEqualToString:@"/private/pushcount.txt"]) {
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
		else if([path isEqualToString:@"/private/pushcount.txt"]) {
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


static FILE * (*orig_fopen) ( const char * filename, const char * mode );
FILE * new_fopen ( const char * filename, const char * mode ) {
    if (strcmp(filename, "/bin/bash") == 0 || strcmp(filename, "/Applications/Cydia.app") == 0 || strcmp(filename, "/Library/MobileSubstrate/MobileSubstrate.dylib") == 0 || strcmp(filename, "/usr/sbin/sshd") == 0 || strcmp(filename, "/etc/apt") == 0) {
        return NULL;
    }
    return orig_fopen(filename, mode);
}

%ctor 
	{
		%init;
		MSHookFunction((void *)fopen, (void *)new_fopen, (void **)&orig_fopen);		
}
