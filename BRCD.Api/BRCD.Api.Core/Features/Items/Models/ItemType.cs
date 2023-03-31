namespace BRCD.Api.Core.Features.Items.Models
{
    public record ItemType
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string? Description { get; set; }
    }
}
