void main() {
  if(GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_REMOVED) {
    CopyItem(GetInventoryDisturbItem(),OBJECT_SELF,FALSE);
  }
}
