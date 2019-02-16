#import <substrate.h>
#import <mach-o/dyld.h>


int (*orig_1001E3CE0)(void);

int sub_1001E3CE0(void)
{
    return 0;
}

%ctor
{
    @autoreleasepool
    {
	unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x1001E3CE0;
        MSHookFunction((void *)test1, (void *)sub_1001E3CE0, (void **)&orig_1001E3CE0);
		
    }
}

