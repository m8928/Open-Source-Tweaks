#import <substrate.h>
#import <mach-o/dyld.h>

int (*orig_1000CF750)(void);

int sub_1000CF750(void)
{
    return 0;
}

%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x1000CF750;
        MSHookFunction((void *)test1, (void *)sub_1000CF750, (void **)&orig_1000CF750);
		
    }
}
