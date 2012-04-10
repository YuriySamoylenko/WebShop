using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace BLL
{
    public enum StatusCode : int
    {
        SendToConfirmation = 1,
        Confirmed = 3,
        Delivered = 4,
        Canceled = 5,
        Unexecuted = 8
    }
}