namespace NetflixStyleAppBlazor.Models
{
    /// <summary>
    /// Representa um utilizador da aplicação
    /// </summary>
    public class User
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Email { get; set; }
        public string? PasswordHash { get; set; }
        public ICollection<UserFavorite> Favorites { get; set; } = new List<UserFavorite>();
    }
}
