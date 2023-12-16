// Name     : Container Persistence OnClose Functions
// Purpose  : Store container contents persistently
// Authors  : GrapeApe
// Modified : March 25, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "container_inc"

void main()
{
    // store all items to the DB
    ContainerSetPersistentContentsByPC(OBJECT_SELF, GetLastClosedBy());
    return;
}
