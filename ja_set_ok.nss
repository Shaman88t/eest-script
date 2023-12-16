#include "ja_variables"

void main()
{
    SetLocalInt( GetPCSpeaker(), "JA_OK_"+GetTag(OBJECT_SELF), 1);
}
