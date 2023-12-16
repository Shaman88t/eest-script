#include "ja_variables"

void main()
{
    SetLocalInt( GetPCSpeaker(), "JA_"+GetTag(OBJECT_SELF), 1);
}
