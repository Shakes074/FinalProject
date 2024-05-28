using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interface;

public interface IMember
{
    public List<ViewMember> ViewMember();
    public bool RegisterMember(InsertMember member);

}
