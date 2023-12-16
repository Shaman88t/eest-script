void main()
{
   int iPN = GetListenPatternNumber();

   if( iPN == -1 ){
    SpeakString("*ignoruje te*");
   }
}
