using Models;

namespace Interface;

public interface IMember
{
    public List<ViewMember> ViewMember();
    public bool RegisterMember(InsertMember member);

    public List<ViewMember> LoginMember(string email, string password);

}
