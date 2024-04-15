
package com.team.dto.asosdalyinfo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Item {

    public String stnId;
    public String stnNm;
    public String tm;
    public String avgTa;
    public String minTa;
    public String minTaHrmt;
    public String maxTa;
    public String maxTaHrmt;
    public String mi10MaxRn;
    public String mi10MaxRnHrmt;
    public String hr1MaxRn;
    public String hr1MaxRnHrmt;
    public String sumRnDur;
    public String sumRn;
    public String maxInsWs;
    public String maxInsWsWd;
    public String maxInsWsHrmt;
    public String maxWs;
    public String maxWsWd;
    public String maxWsHrmt;
    public String avgWs;
    public String hr24SumRws;
    public String maxWd;
    public String avgTd;
    public String minRhm;
    public String minRhmHrmt;
    public String avgRhm;
    public String avgPv;
    public String avgPa;
    public String maxPs;
    public String maxPsHrmt;
    public String minPs;
    public String minPsHrmt;
    public String avgPs;
    public String ssDur;
    public String sumSsHr;
    public String hr1MaxIcsrHrmt;
    public String hr1MaxIcsr;
    public String sumGsr;
    public String ddMefs;
    public String ddMefsHrmt;
    public String ddMes;
    public String ddMesHrmt;
    public String sumDpthFhsc;
    public String avgTca;
    public String avgLmac;
    public String avgTs;
    public String minTg;
    public String avgCm5Te;
    public String avgCm10Te;
    public String avgCm20Te;
    public String avgCm30Te;
    public String avgM05Te;
    public String avgM10Te;
    public String avgM15Te;
    public String avgM30Te;
    public String avgM50Te;
    public String sumLrgEv;
    public String sumSmlEv;
    public String n99Rn;
    public String iscs;
    public String sumFogDur;

}
