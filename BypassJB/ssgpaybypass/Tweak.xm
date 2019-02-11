#import <substrate.h>
#import <mach-o/dyld.h>

void (*orig_100BE222C)(void);

void sub_100BE222C(void)
{
    ;
}




%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x100BE222C;
        MSHookFunction((void *)test1, (void *)sub_100BE222C, (void **)&orig_100BE222C);

    }
}