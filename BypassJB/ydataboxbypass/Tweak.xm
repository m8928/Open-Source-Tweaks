#import <substrate.h>
#import <mach-o/dyld.h>

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/sh"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

%hook IxShieldController 
+(bool)systemCheck{
	return true;
}
%end

int (*orig_10041CB60)(void);

int sub_10041CB60(void)
{
    return 1;
}

int (*orig_10041DA8C)(void);

int sub_10041DA8C(void)
{
    return 1;
}

%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x10041CB60;
        MSHookFunction((void *)test1, (void *)sub_10041CB60, (void **)&orig_10041CB60);

        unsigned long test2 = _dyld_get_image_vmaddr_slide(0) + 0x10041DA8C;
        MSHookFunction((void *)test2, (void *)sub_10041DA8C, (void **)&orig_10041DA8C);
		
    }
}