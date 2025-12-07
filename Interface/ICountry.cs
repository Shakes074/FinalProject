using Models;
namespace Interface
{
    public interface ICountry
    {
        List<Country> CountryNames { get; }
        List<Province> ProvinceName { get; }
    }
}
