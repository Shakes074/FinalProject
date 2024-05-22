using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interface
{
    public interface ICountry  
    {
        List<Country> CountryNames { get; }
        List<Province> ProvinceName { get; }
    }
}
