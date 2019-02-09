%hook NSString 
- (BOOL)writeToFile:(NSString *)path {
		if([path isEqualToString:@"/private/jailbreak.txt"]) {
			return NO;
			} 
		else {
			return %orig;
			}
	}
%end

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} else if([path isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/sbin/sshd"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/apt"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/lib/hacktivate.dylib"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/blackra1n.app"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/apt"]) {
					return NO;
				} else {
					return %orig;
					}
				}

- (BOOL)removeItemAtPath:(NSString *)path {
		if([path isEqualToString:@"/private/jailbreak.txt"]) {
					return NO;
				} 
				else {
					return %orig;
					}
				}		
%end