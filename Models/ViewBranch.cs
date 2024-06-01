namespace Models;

public class ViewBranch
{
    public int ID { get; set; }
    public string Name { get; set; }
    public string Province { get; set; }
    public string Country { get; set; }
    public int Total_Members { get; set; }
}

public class ViewBranchCountries 
{
    public string Country { get; set; }
}

public class ViewBranchesProvinces
{
   public string Province { get; set; }
}

public class ViewProvinceBranches
{
    public string Name { get; set; }
}
