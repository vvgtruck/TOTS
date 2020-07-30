using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class ShopFloorWeekday : Weekday
    {
      
        public string Invoice { get; set; }

        public string CusName { get; set; }

        public float Duration { get; set; }
    }
}
