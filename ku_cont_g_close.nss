// Name     : Container Persistence OnClose Functions
// Purpose  : Store container gold persistently
// Authors  : Kucik
// Modified : March 29, 2008

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "container_inc"

void main()
{
    // store all items to the DB
    ContainerSetPersistentGold(OBJECT_SELF);
    return;
}
