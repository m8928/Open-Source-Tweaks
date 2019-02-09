#include <sys/stat.h>
#import <mach-o/dyld.h>


%hook SFAntiPiracy 
+(void)lllI {
 ;
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
				} else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/RockApp.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/Icy.app"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/bin/sshd"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/libexec/sftp-server"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/WinterBoard.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/SBSettings.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/MxTube.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/IntelliScreen.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/stash"]) {
					return NO;
				} else if([path isEqualToString:@"/System/Library/LaunchDaemons/com.ikey.bbot.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/tmp/cydia.log"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/cydia"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/clutch.conf"]) {
					return NO;
				} else if([path isEqualToString:@"/var/cache/clutch.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/clutch_cracked.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/var/cache/clutch_cracked.plist"]) {
					return NO;
				} else if([path isEqualToString:@"/var/lib/clutch/overdrive.dylib"]) {
					return NO;
				} else if([path isEqualToString:@"/var/root/Documents/Cracked/"]) {
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
		else if([[url absoluteString] isEqualToString:@"cydia://package/com.fake.package"]) {
		return NO;
				}
		else {
					return %orig;
					}
				}
%end

%hook amsLibrary
-(long long) a3142: (id) arg1 {
  return %orig - 10;
}
%end

static int (*orig_stat)(const char * file_name, struct stat *buf);
int new_stat(const char * file_name, struct stat *buf) {
    if (strcmp(file_name, "/bin/sh") == 0) {  
        return -1;
    }
    return orig_stat(file_name, buf);
}

static FILE * (*orig_fopen) ( const char * filename, const char * mode );
FILE * new_fopen ( const char * filename, const char * mode ) {
    if (strcmp(filename, "/bin/bash") == 0 || strcmp(filename, "/Applications/Cydia.app") == 0 || strcmp(filename, "/Library/MobileSubstrate/MobileSubstrate.dylib") == 0 || strcmp(filename, "/usr/sbin/sshd") == 0 || strcmp(filename, "/var/cache/apt") == 0 || strcmp(filename, "/var/lib/apt") == 0 || strcmp(filename, "/var/lib/cydia") == 0 || strcmp(filename, "/var/log/syslog") == 0 || strcmp(filename, "/var/tmp/cydia.log") == 0 || strcmp(filename, "/bin/sh") == 0 || strcmp(filename, "/usr/libexec/ssh-keysign") == 0 || strcmp(filename, "/etc/ssh/sshd_config") == 0 || strcmp(filename, "/etc/apt") == 0) {
        return NULL;
    }
    return orig_fopen(filename, mode);
}

static int (*orig_lstat)(const char *path, struct stat *buf);
int new_lstat(const char *path, struct stat *buf) {
    if (strcmp(path, "/Applications") == 0) {
        return -1;
    }
    return orig_lstat(path, buf);
}

MSHook(const char*, _dyld_get_image_name, uint32_t image_index)
{
    
    const char* dyld= __dyld_get_image_name(image_index);
    if(strstr(dyld, "MobileSubstrate"))
    {
        return "";
    }else{
        return dyld;
    }
}

%ctor 
	{
		%init;
		MSHookFunction(_dyld_get_image_name, MSHake(_dyld_get_image_name));
		MSHookFunction((void *)fopen, (void *)new_fopen, (void **)&orig_fopen);
		MSHookFunction((void *)stat, (void *)new_stat, (void **)&orig_stat);
		MSHookFunction((void *)lstat, (void *)new_lstat, (void **)&orig_lstat);
	}