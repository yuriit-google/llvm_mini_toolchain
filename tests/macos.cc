#include <iostream>
#include <vector>
#include <CoreFoundation/CFTimeZone.h>

using namespace std;

int main() {
  cout << "Hello C++ World!" << endl;

  std::vector<char> buffer;
  CFTimeZoneRef tz_default = CFTimeZoneCopyDefault();
  if (CFStringRef tz_name = CFTimeZoneGetName(tz_default)) {
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    CFIndex length = CFStringGetLength(tz_name);
    CFIndex max_size = CFStringGetMaximumSizeForEncoding(length, encoding) + 1;
    buffer.resize(static_cast<size_t>(max_size));
    if (CFStringGetCString(tz_name, &buffer[0], max_size, encoding)) {
      //zone = &buffer[0];
    }
  }
  CFRelease(tz_default);


  return 0;
}

