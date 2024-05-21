using Models;

namespace Interface;
public interface IBranch
{
    public bool RegisterBranch(InsertBranch branch);
    public List<ViewBranch> ViewBranches();
}
