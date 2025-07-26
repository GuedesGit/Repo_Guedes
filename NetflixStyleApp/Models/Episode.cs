namespace NetflixStyleApp.Models
{
    /// <summary>
    /// Representa um episódio de uma série
    /// </summary>
    public class Episode
    {
        public int Id { get; set; }
        public int SeriesId { get; set; }
        public string Title { get; set; }
        public int Number { get; set; }
        public string Description { get; set; }
    }
}
