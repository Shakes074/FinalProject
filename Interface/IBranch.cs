using Models;

namespace Interface;
public interface IBranch
{
    public bool RegisterBranch(InsertBranch branch);
    public List<ViewBranch> ViewBranches();
    
    public List<ViewBranchCountries> GetCoutries();
    public List<ViewBranchesProvinces> GetProvinces(ViewBranchCountries country);
    public List<ViewProvinceBranches> GetBranches(ViewBranchesProvinces provinces);

}
