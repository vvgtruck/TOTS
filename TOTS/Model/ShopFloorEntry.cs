using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class ShopFloorEntry : WeekdayEntry
    {
        public List<ShopFloorWeekday> shopFloorWeekdays { get; set; }

        public float TShopFloorHours { get; set; }

    }
}