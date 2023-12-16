// Name     : Container Persistence OnOpen Functions
// Purpose  : Load container gold from persistence
// Authors  : Kucik
// Modified : March 29, 2008

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "container_inc"

void main()
{
    // load all items from DB
    ContainerGetPersistentGold(OBJECT_SELF);
    return;
}
