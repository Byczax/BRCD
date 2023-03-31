using BRCD.Api.Core.Features.Items.Models;
using BRCD.Api.Core.Features.Users.Models;
using BRCD.Api.Core.InMemory;

namespace BRCD.Api.Core.Features.Items.Implementations
{
    public class InMemoryItemRepository : IItemRepository
    {
        private InMemoryData data;
        public InMemoryItemRepository()
        {
            data = InMemoryData.Instance;
        }

        public Item CreateItem(ItemCreate item)
        {
            Random random = new Random();
            int newId;
            do
            {
                newId = random.Next();
            } while (data.Items.Count(x => x.Id == newId) > 1);

            Item newItem = new Item()
            {
                Id = newId,
                Barcode = $"Item-{newId:000}",
                CreatedBy = item.CreatedBy,
                CreatedDate = DateTime.Now,
                Description = item.Description,
                Removed = false,
                ResponsibleUser = item.ResponsibleUser ?? item.CreatedBy,
                Type = item.Type,
            };
            
            data.Items.Add(newItem);

            return newItem;
        }

        public ItemType CreateItemType(ItemTypeCreate type)
        {
            Random random = new Random();
            int newId;
            do
            {
                newId = random.Next();
            } while (data.ItemTypes.Count(x => x.Id == newId) > 1);

            ItemType newItem = new ItemType()
            {
                Id = newId,
                Name = type.Name,
                Description = type.Description,
            };

            data.ItemTypes.Add(newItem);

            return newItem;
        }

        public List<Item> GetAllItems() => InMemoryData.Instance.Items;

        public List<ItemType> GetAllItemTypes() => InMemoryData.Instance.ItemTypes;

        public Item? GetItem(int id) => InMemoryData.Instance.Items
            .FirstOrDefault(x => x.Id == id);

        public Item? GetItem(string barcode) => InMemoryData.Instance.Items
            .FirstOrDefault(x => x.Barcode == barcode);

        public List<Item> GetItemsCreatedBy(User user) => InMemoryData.Instance.Items
            .Where(x => x.CreatedBy.Id == user.Id)
            .ToList();

        public List<Item> GetItemsOfUser(User responsibleUser) => InMemoryData.Instance.Items
            .Where(x => x.ResponsibleUser.Id == responsibleUser.Id)
            .ToList();

        public ItemType? GetItemType(int id) => InMemoryData.Instance.ItemTypes
            .FirstOrDefault(x => x.Id == id);
    }
}
