using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ProvinceDTO 
    {
        public bool error { get; set; }
        public string msg { get; set; }
        public  data data { get; set; }
    }
    public class data 
    {
        public string name { get; set; }
        public string Iso2 { get; set; }
        public string Iso3 { get; set; }
        public List<Province> states { get; set; }
    }
    public class Province
    {
        public string name { get; set; }
        public string state_code { get; set; }
    }
}
