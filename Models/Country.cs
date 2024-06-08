namespace Models
{
    public class CountryDTO
    {
        public bool error { get; set; }
        public string msg { get; set; }
        public List<Country> data { get; set; }

    }
    public class Country
    {
        public string name { get; set; }
        public string Iso2 { get; set; }
        public string Iso3 { get; set; }
    }
}
