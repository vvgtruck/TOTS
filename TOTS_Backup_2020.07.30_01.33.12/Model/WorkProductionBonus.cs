using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TOTS.Model
{
    public class WorkProductionBonus
    {

        public string Type { get; set; }

        public string DateInvoice { get; set; }

        public string SlsId { get; set; }

        public int OpsId { get; set; }

        public string CusName { get; set; }

        public string SvItm { get; set; }

        public string Des { get; set; }

        public float HrsBill { get; set; }

        public float HrsActual { get; set; }

        public float Difference { get; set; }

    }
}