#import <substrate.h>
#import <mach-o/dyld.h>

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/sh"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

%hook UIApplication 
- (BOOL)canOpenURL:(NSURL *)url {
    if([[url absoluteString] isEqualToString:@"cydia://"]) {
		return NO;
				}

		else {
					return %orig;
					}
				}
%end


bool (*orig_1000F7850)(void);

bool sub_1000F7850(void)
{
   return 1;
}


%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x1000F7850;
        MSHookFunction((void *)test1, (void *)sub_1000F7850, (void **)&orig_1000F7850);
		
    }
}

