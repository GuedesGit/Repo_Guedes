using Microsoft.EntityFrameworkCore;
using NetflixStyleApp.Models;

namespace NetflixStyleApp.Data
{
    /// <summary>
    /// DbContext para a aplicação
    /// </summary>
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Movie> Movies { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Episode> Episodes { get; set; }
    }
}
