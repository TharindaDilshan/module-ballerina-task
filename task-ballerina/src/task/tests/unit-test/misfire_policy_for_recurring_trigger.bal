// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/runtime;
import ballerina/test;

int triggeredCount2 = 0;

service misfireService2 = service {
    resource function onTrigger() {
        triggeredCount2 = triggeredCount2 + 1;
    }
};

@test:Config {}
function testExistingRepeatCountWithService2() returns error? {
    Scheduler taskTimer = new ({ intervalInMillis: 3000, noOfRecurrences: 5 ,
                                 misfirePolicy: "fireNowWithExistingCount" });
    check taskTimer.attach(misfireService2);
    check taskTimer.start();
     // Sleep for 8 seconds.
    runtime:sleep(8000);
    test:assertEquals(triggeredCount2, 2, msg = "Expected count mismatched before pausing the scheduler.");
    check taskTimer.pause();
    runtime:sleep(8000);
    test:assertEquals(triggeredCount2, 2, msg = "Expected count mismatched during the scheduler pause.");
    check taskTimer.resume();
    runtime:sleep(1000);
    test:assertEquals(triggeredCount2, 3, msg = "Expected count mismatched after resuming the scheduler.");
    runtime:sleep(8000);
    test:assertEquals(triggeredCount2, 5, msg = "Expected count mismatched.");
    check taskTimer.stop();
}

int triggeredCount3 = 0;

service misfireService3 = service {
    resource function onTrigger() {
        triggeredCount3 = triggeredCount3 + 1;
    }
};

@test:Config {}
function testNowWithRemainingRepeatCountWithService3() returns error? {
    Scheduler taskTimer = new ({ intervalInMillis: 3000, noOfRecurrences: 7,
                                 misfirePolicy: "fireNowWithRemainingCount"});
    check taskTimer.attach(misfireService3);
    check taskTimer.start();
    runtime:sleep(8000);
    test:assertEquals(triggeredCount3, 2, msg = "Expected count mismatched before pausing the scheduler.");
    check taskTimer.pause();
    runtime:sleep(8000);
    test:assertEquals(triggeredCount3, 2, msg = "Expected count mismatched during the scheduler pause.");
    check taskTimer.resume();
    runtime:sleep(1000);
    test:assertEquals(triggeredCount3, 3, msg = "Expected count mismatched after resuming the scheduler.");
    runtime:sleep(8000);
    test:assertEquals(triggeredCount3, 5, msg = "Expected count mismatched.");
    check taskTimer.stop();
}

int triggeredCount4 = 0;

service misfireService4 = service {
    resource function onTrigger() {
        triggeredCount4 = triggeredCount4 + 1;
    }
};

@test:Config {}
function testNextWithExistingCountWithService4() returns error? {
    Scheduler taskTimer = new ({ intervalInMillis: 3000, noOfRecurrences: 7,
                                 misfirePolicy: "fireNextWithExistingCount"});
    check taskTimer.attach(misfireService4);
    check taskTimer.start();
    runtime:sleep(7000);
    test:assertEquals(triggeredCount4, 2, msg = "Expected count mismatched before pausing the scheduler.");
    check taskTimer.pause();
    runtime:sleep(7000);
    test:assertEquals(triggeredCount4, 2, msg = "Expected count mismatched during the scheduler pause.");
    check taskTimer.resume();
    runtime:sleep(500);
    test:assertEquals(triggeredCount4, 2, msg = "Expected count mismatched after resuming the scheduler.");
    runtime:sleep(10000);
    test:assertEquals(triggeredCount4, 5, msg = "Expected count mismatched.");
    check taskTimer.stop();
}

int triggeredCount5 = 0;

service misfireService5 = service {
    resource function onTrigger() {
        triggeredCount5 = triggeredCount5 + 1;
    }
};
@test:Config {}
function testNextWithRemainigCountWithService5() returns error? {
    Scheduler taskTimer = new ({ intervalInMillis: 3000, noOfRecurrences: 7 ,
                                 misfirePolicy: "fireNextWithExistingCount"});
    check taskTimer.attach(misfireService5);
    check taskTimer.start();
    runtime:sleep(7000);
    test:assertEquals(triggeredCount5, 2, msg = "Expected count mismatched before pausing the scheduler.");
    check taskTimer.pause();
    runtime:sleep(7000);
    test:assertEquals(triggeredCount5, 2, msg = "Expected count mismatched during the scheduler pause.");
    check taskTimer.resume();
    runtime:sleep(500);
    test:assertEquals(triggeredCount5, 2, msg = "Expected count mismatched after resuming the scheduler.");
    runtime:sleep(10000);
    test:assertEquals(triggeredCount5, 5, msg = "Expected count mismatched.");
    check taskTimer.stop();
}

int triggeredCount11 = 0;

service misfireService11 = service {
    resource function onTrigger() {
        triggeredCount11 = triggeredCount11 + 1;
    }
};

@test:Config {}
function testSmartPolicyWithService11() returns error? {
    Scheduler taskTimer = new ({intervalInMillis: 3000, noOfRecurrences: 5 });
    check taskTimer.attach(misfireService11);
    check taskTimer.start();
    runtime:sleep(8000);
    test:assertEquals(triggeredCount11, 2, msg = "Expected count mismatched before pausing the scheduler.");
    check taskTimer.pause();
    runtime:sleep(8000);
    test:assertEquals(triggeredCount11, 2, msg = "Expected count mismatched during the scheduler pause.");
    check taskTimer.resume();
    runtime:sleep(1000);
    test:assertEquals(triggeredCount11, 3, msg = "Expected count mismatched after resuming the scheduler.");
    runtime:sleep(10000);
    test:assertEquals(triggeredCount11, 5, msg = "Expected count mismatched.");
    check taskTimer.stop();
}
