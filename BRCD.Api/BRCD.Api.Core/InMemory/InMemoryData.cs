using BRCD.Api.Core.Features.Items.Models;
using BRCD.Api.Core.Features.Users.Models;

namespace BRCD.Api.Core.InMemory
{
    public class InMemoryData
    {
        private static InMemoryData instance;

        public static InMemoryData Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new InMemoryData();
                }
                return instance;
            }
        }

        public List<Item> Items { get; set; }
        public List<ItemType> ItemTypes { get; set; }
        public List<User> Users { get; set; }

        private InMemoryData(){
            ItemTypes = new List<ItemType>()
            {
                new()
                {
                    Id = 1,
                    Name = "Chair",
                    Description = "A chair used for sitting"
                },
                new()
                {
                    Id = 2,
                    Name = "Gaming PC",
                    Description = "A powerful PC with a great graphics card and lots of RAM"
                },
                new()
                {
                    Id = 3,
                    Name = "Mechanical Keyboard",
                    Description = "Keys go clickity clack!"
                },
            };

            Users = new List<User>() {
                new()
                {
                    Id = 1,
                    Name = "Józek",
                    Active = true,
                    Emails = new List<string> {"jusk@example.com"},
                    PhoneNumbers = new List<string> {"123666420"}
                },
                new()
                {
                    Id = 2,
                    Name = "Byczko",
                    Active = true,
                    Emails = new List<string> {"byq@byczko.com"},
                    PhoneNumbers = new List<string> {"456988007"}
                },
                new()
                {
                    Id = 3,
                    Name = "Docent",
                    Active = true,
                    Emails = new List<string> {"ChessMaster69@example.com"},
                    PhoneNumbers = new List<string> {"+48 777213700", "123456789"}
                },
            };

            Items = Enumerable.Range(0, 10)
                .Select(i => new Item() {
                    Id = i,
                    Barcode = $"Item-{i:000}",
                    Type = ItemTypes[i%ItemTypes.Count],
                    CreatedBy = Users[i%Users.Count],
                    CreatedDate = DateTime.Now,
                    ResponsibleUser = Users[i%Users.Count],
                    Removed = false
                })
                .ToList();
        }
    }
}
