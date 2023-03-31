using BRCD.Api.Core.Features.Items.Models;
using BRCD.Api.Core.Features.Users.Models;

namespace BRCD.Api.Core.Features.Items
{
    public interface IItemRepository
    {
        Item? GetItem(int id);

        Item? GetItem(string barcode);

        List<Item> GetAllItems();

        List<Item> GetItemsCreatedBy(User user);

        List<Item> GetItemsOfUser(User responsibleUser);

        Item CreateItem(ItemCreate item);

        ItemType GetItemType(int id);

        List<ItemType> GetAllItemTypes();

        ItemType? CreateItemType(ItemTypeCreate type);
    }
}
