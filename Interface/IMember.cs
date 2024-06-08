using Models;

namespace Interface;

public interface IMember
{
    public List<ViewMember> ViewMember();
    public bool RegisterMember(InsertMember member);

    public ViewMember LoginMember(LoginModel model);

    public List<ViewMember> UpdateByUser(InsertMember member);

}
