using BRCD.Api.Core.Features.Users.Models;

namespace BRCD.Api.Core.Features.Items.Models
{
    public record Item
    {
        public int Id { get; set; }

        public string Barcode { get; set; }

        public ItemType Type { get; set; }

        public string? Description { get; set; }

        public DateTime CreatedDate { get; set; }

        public bool Removed { get; set; }

        public DateTime? RemovedDate { get; set; }

        public User CreatedBy { get; set; }

        public User ResponsibleUser { get; set; }
    }
}
