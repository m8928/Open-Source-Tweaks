%hook NSString 
- (BOOL)writeToFile:(NSString *)path  {
		if([path isEqualToString:@"/private/JailbreakTest.txt"]) {
					return NO;
				} 
				else {
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

%hook NSFileManager
- (BOOL)removeItemAtPath:(NSString *)path {
		if([path isEqualToString:@"/private/JailbreakTest.txt"]) {
					return NO;
				} 
				else {
					return %orig;
					}
				}	
				
								

- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/blackra1n.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/FakeCarrier.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/Icy.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/IntelliScreen.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/MxTube.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/RockApp.app"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/Applications/SBSettings.app"]) {
					return NO;
				}
				  else if([path isEqualToString:@"/Applications/WinterBoard.app"]) {
					return NO;
				}
				  else if([path isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/private/var/mobile/Library/SBSettings/Themes"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/private/var/stash"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/private/var/lib/cydia"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/System/Library/LaunchDaemons/com.ikey.bbot.plist"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/bin/basn/sshd"]) {
					return NO;
				}
				  else if([path isEqualToString:@"/usr/sbin"]) {
					return NO;
				} 
				  else if([path isEqualToString:@"/usr/sbi"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/apt"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end