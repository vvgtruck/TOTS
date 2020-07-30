using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class ShopFloor
    {

        public Dictionary<string, ShopFloorEntry> shopFloorEntries = new Dictionary<string, ShopFloorEntry>();

        public float TShopFloorHours { get; set; }

    }
}