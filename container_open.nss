// Name     : Container Persistence OnOpen/OnModLoad Functions
// Purpose  : Load container contents from persistent database
// Authors  : GrapeApe
// Modified : March 25, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "container_inc"

void main()
{
    // load all items from the DB
    ContainerGetPersitentContents(OBJECT_SELF);
    return;
}
