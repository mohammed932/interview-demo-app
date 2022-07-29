package com.t2.microAppService;

public class MicroSharedData {

    private static MicroSharedData microSharedData;
    private ReCall reCall;
    public String microAppData;
    public String route;

    public interface ReCall {
        void CheckFromOtherMicroApp();
    }

    public static MicroSharedData getInstance() {
        if (microSharedData == null)
            microSharedData = new MicroSharedData();
        return microSharedData;
    }

    public void setReCall(ReCall reCall) {
        this.reCall = reCall;
    }

    public void microAppReRoute() {
        if (reCall != null)
            reCall.CheckFromOtherMicroApp();
    }

    private MicroSharedData() {
    }
}
