using Models;
namespace Interface;
public interface IMember
{
    public List<ViewMember> ViewMember();
    public bool RegisterMember(InsertMember member);
    public bool UpdateMember(InsertMember member, int Id);
    public ViewMember LoginMember(LoginModel model);
    public List<ViewMember> UpdateByUser(InsertMember member);
   
    public List<MemberGroup> GetMemberGroup();
    public List<MemberInBranch> GetMemberInBranch();
    public List<MemberStatus> GetMembersStatus();
    public List<MemberActivitites> GetMembersActivitites();

    

}
