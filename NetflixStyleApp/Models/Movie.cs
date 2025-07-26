namespace NetflixStyleApp.Models
{
    /// <summary>
    /// Representa um filme ou série
    /// </summary>
    public class Movie
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public string Category { get; set; }
        public int Year { get; set; }
        public bool IsSeries { get; set; }
    }
}
