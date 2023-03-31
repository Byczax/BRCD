namespace BRCD.Api.Core.Features.Users.Models
{
    public class User
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public bool Active { get; set; } = true;

        public List<string> Emails { get; set; }

        public List<string> PhoneNumbers { get; set; }
    }
}
