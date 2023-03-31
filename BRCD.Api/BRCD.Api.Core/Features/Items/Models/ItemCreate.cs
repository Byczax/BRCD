using BRCD.Api.Core.Features.Users.Models;

namespace BRCD.Api.Core.Features.Items.Models
{
    public class ItemCreate
    {
        public string? Barcode { get; set; }

        public ItemType Type { get; set; }

        public string? Description { get; set; }

        public User CreatedBy { get; set; }

        public User? ResponsibleUser { get; set; }
    }
}
