using NetflixStyleAppBlazor.Models;

public class UserFavorite
{
    public int Id { get; set; } // Chave primária
    public int UserId { get; set; }
    public User? User { get; set; }
    public int MovieId { get; set; }
    public Movie? Movie { get; set; }
    public DateTime CreatedAt { get; set; }
}