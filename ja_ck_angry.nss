#include "ja_variables"

int StartingConditional()
{
    return GetLocalInt( GetPCSpeaker(), "JA_"+GetTag(OBJECT_SELF));
}
