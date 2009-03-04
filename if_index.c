/* if_index.c
**
** Copyright 2007, The Android Open Source Project
**
** Licensed under the Apache License, Version 2.0 (the "License"); 
** you may not use this file except in compliance with the License. 
** You may obtain a copy of the License at 
**
**     http://www.apache.org/licenses/LICENSE-2.0 
**
** Unless required by applicable law or agreed to in writing, software 
** distributed under the License is distributed on an "AS IS" BASIS, 
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
** See the License for the specific language governing permissions and 
** limitations under the License.
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#include <sys/socket.h>
#include <sys/select.h>
#include <sys/types.h>
#include <netinet/in.h>

#include <linux/if.h>
#include <linux/sockios.h>
#include <linux/route.h>

unsigned int if_nametoindex( const char *ifname )
{
#ifndef SIOCGIFINDEX
    return 0;
#else
    struct ifreq ifr;
    int fd = socket(AF_INET, SOCK_DGRAM, 0);    

    if (fd < 0)
        return 0;

    strncpy(ifr.ifr_name, ifname, sizeof (ifr.ifr_name));
    ifr.ifr_ifindex = 0;
    if (ioctl (fd, SIOCGIFINDEX, &ifr) < 0) {
        return 0;
    }
    return ifr.ifr_ifindex;
#endif
}
