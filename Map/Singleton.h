//Using a macro to define a single object

// .h
#define single_interface(class)  + (class *)shared##class;

// .m
// \ Representing the next line is also a macro
// ## Is a separator
#define single_implementation(class) \
static class *_instance; \
 \
+ (class *)shared##class \
{ \
    if (_instance == nil) { \
        _instance = [[self alloc] init]; \
    } \
    return _instance; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
}

